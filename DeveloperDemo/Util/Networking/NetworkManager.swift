//
//  NetworkManager.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Combine
import Foundation
import OSLog

final class NetworkManager: NSObject {
    
    // MARK: - Singleton
    static let shared = NetworkManager()
    
    
    // MARK: - Value
    // MARK: Private
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = false
        
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        urlSession.configuration.allowsConstrainedNetworkAccess = false
        urlSession.configuration.allowsExpensiveNetworkAccess = true
        return urlSession
    }()
    
    private var retryURLs = Set<URL>()
    
    private var refreshTokenTask: Task<(String, String), Error>?
    private var guestTokenTask: Task<(String, String), Error>?
    
    
    // MARK: - Initializer
    private override init() {
        super.init()
    }
    
    
    // MARK: - Function
    // MARK: Public
    @discardableResult
    func request(urlRequest: URLRequest, requestData: Encodable? = nil) async throws -> HTTPResponse {
        guard let request = encode(urlRequest: urlRequest, requestData: requestData) else { throw URLError(.badURL) }
        #if DEBUG
        Logger(subsystem: "Network", category: "Request").debug("\(request.debugDescription)")
        #endif
        
        // Request
        let (data, urlResponse) = try await urlSession.data(for: request)
        return try await handle(data: data, urlRequest: request, urlResponse: urlResponse)
    }
    
    // MARK: Private
    private func encode(urlRequest: URLRequest, requestData: Encodable?) -> URLRequest? {
        guard let requestData else { return urlRequest }
        var request = urlRequest
        
        guard let httpMethod = HTTPMethod(request: request) else {
            #if DEBUG
            Logger(subsystem: "Network", category: "Encode").error("HTTP method is invalid.")
            #endif
            return nil
        }
        
        switch httpMethod {
        case .get:
            guard let urlComponets = urlComponents(request: request, data: requestData) else { return nil }
            request.url = urlComponets.url
            
        case .patch, .put, .post, .delete:
            if let contentType = request.value(forHTTPHeaderField: HTTPHeaderField.contentType.rawValue) {
                if contentType.range(of: ApplicationMediaSet.urlEncoded.types) != nil {
                    request.httpBody = urlComponents(request: request, data: requestData)?.query?.data(using: .utf8, allowLossyConversion: false)
                    
                } else if contentType.range(of: ApplicationMediaSet.json.types) != nil {
                    do { request.httpBody = try encoder.encode(requestData) } catch { return nil }
                    
                } else if contentType.hasPrefix(HTTPHeaderValue.multipart(.none).rawValue) {
                    request.httpBody = requestData as? Data
                }
                
            } else {
                request.httpBody = urlComponents(request: request, data: requestData)?.query?.data(using: .utf8)
            }
        }
        
        return request
    }
    
    private func urlComponents<T: Encodable>(request: URLRequest, data: T) -> URLComponents? {
        guard let string = request.url?.absoluteString, var urlComponent = URLComponents(string: string) else { return nil }
        
        do {
            guard var jsonData = try JSONSerialization.jsonObject(with: encoder.encode(data), options: .mutableContainers) as? [String: Any] else { return nil }
            
            // Remove null container
            for key in jsonData.keys.filter({ jsonData[$0] is NSNull }) { jsonData.removeValue(forKey: key) }
            
            var mediaSet = ApplicationMediaSet(value: request.value(field: .contentType)) 
            
            // Adds x-www-form-urlencoded for GET requests for Demo (e.g., space as '+').
            if request.httpMethod == HTTPMethod.get.rawValue, hosts.api.rawValue.contains(request.url?.host ?? "") {
                mediaSet.insert(.urlEncoded)
            }
            
            var query = ""
            
            for (key, value) in jsonData {
                switch value {
                case let list as [Any]:
                    list.forEach {
                        guard let encodedQuery = encode(key, $0, mediaSet) else { return }
                        query += "\(query.isEmpty ? "" : "&")\(encodedQuery)"
                    }
                
                default:
                    guard let encodedQuery = encode(key, value, mediaSet) else { continue }
                    query += "\(query.isEmpty ? "" : "&")\(encodedQuery)"
                }
            }
            
            urlComponent.percentEncodedQuery = query
            return urlComponent
            
        } catch {
            #if DEBUG
            Logger(subsystem: "Network", category: "Encode").error("Failed to get a query.")
            #endif
            return nil
        }
    }
    
    private func encode(_ key: String, _ value: Any, _ mediaSet: ApplicationMediaSet?) -> String? {
        guard let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            #if DEBUG
            Logger(subsystem: "Network", category: "Encode").error("Failed to encode a \(key)")
            #endif
            return nil
        }
        
        let isURLEncoded = mediaSet?.contains(.urlEncoded) ?? false
        let characterSet: CharacterSet = isURLEncoded ? .alphanumerics.union(CharacterSet(charactersIn: "-._~")) : .urlQueryAllowed
        
        guard let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: characterSet) else {
            #if DEBUG
            Logger(subsystem: "Network", category: "Encode").error("Failed to encode a \("\(value)")")
            #endif
            return nil
        }
        
        return "\(encodedKey)=\(isURLEncoded ? encodedValue.replacingOccurrences(of: "%20", with: "+") : encodedValue)"
    }
    
    private func handleSSL(_ session: Foundation.URLSession, challenge: URLAuthenticationChallenge) -> Bool {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            #if DEBUG
            Logger(subsystem: "Network", category: "SSL").error("Failed to get a authenticationMethod.")
            #endif
            return false
        }
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            #if DEBUG
            Logger(subsystem: "Network", category: "SSL").error("Failed to set trust policies.")
            #endif
            return false
        }
        
        var error: CFError? = nil
        guard SecTrustEvaluateWithError(serverTrust, &error), error == nil else {
            #if DEBUG
            Logger(subsystem: "Network", category: "SSL").error("Failed to check the server trust. \(error?.localizedDescription ?? "")")
            #endif
            return false
        }
        
        return true
    }
    
    private func handle(data: Data?, urlRequest: URLRequest, urlResponse: URLResponse?) async throws -> HTTPResponse {
        let response = try HTTPResponse(data: data, urlResponse: urlResponse)
        
        #if os(iOS)
        handle(experiment: response.experiment)
        #endif
        
        switch response.statusCode {
        case .ok, .created, .accepted, .nonAuthoritativeInformation, .noContent, .resetContent, .partialContent, .multiStatus, .alreadyReported, .imUsed, .unprocessableEntity:
            #if DEBUG
            Logger(subsystem: "Network", category: "Response").debug("\(response.debugDescription)")
            #endif
            
        case .unauthorized:
            #if DEBUG
            Logger(subsystem: "Network", category: "Response").error("\(response.debugDescription)")
            #endif
            
            switch response.error?.code {
            case 1001:
                let (accessToken, refreshToken) = try await requestGuestToken()
                
                await SessionManager.shared.update(
                    accessToken: accessToken,
                    refreshToken: refreshToken
                )
                
            case 1002:
                let (accessToken, refreshToken) = try await refreshToken()
                
                await SessionManager.shared.update(
                    accessToken: accessToken,
                    refreshToken: refreshToken
                )
                
                var urlRequest = urlRequest
                urlRequest.set(value: accessToken ?? "", field: .serviceAuthorization)
            
                return try await retry(urlRequest: urlRequest)
                
            case 1003:
                Task {
                    await SessionManager.shared.logout()
                    
                    // Log
                    let properties: AmplitudeEventProperties = [
                        .deviceID: PushManager.shared.pushDeviceID,
                        .cause: LogoutCauseType.etc.rawValue,
                        .detailedCause: "API service 401, 1003",
                        .jwt: await TokenManager.shared.accessToken]
                    
                    AmplitudeEvent.name(.logout)?.properties(properties).send()
                }
                
            default:
                break
            }
            
            throw response.error ?? URLError(.userAuthenticationRequired)
    
        default:
            #if DEBUG
            Logger(subsystem: "Network", category: "Response").error("\(response.debugDescription)")
            #endif
            throw response.error ?? URLError(.badServerResponse)
        }
        
        return response
    }
    
    private func retry(urlRequest: URLRequest) async throws -> HTTPResponse {
        guard let url = urlRequest.url else { throw URLError(.badURL) }
        
        try await NetworkActor.run {
            guard !retryURLs.contains(url) else { throw URLError(.badURL) }
            retryURLs.insert(url)
        }
        
        #if DEBUG
        Logger(subsystem: "Network", category: "Retry").error("\(urlRequest.debugDescription)")
        #endif
        
        // Retry
        do {
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            await NetworkActor.run { retryURLs.remove(url) }
            
            return try await handle(data: data, urlRequest: urlRequest, urlResponse: urlResponse)
        
        } catch {
            await NetworkActor.run { retryURLs.remove(url) }
            throw error
        }
    }
    
    private func requestGuestToken() async throws -> (String, String) {
        // Task 캐싱 패턴: Guest Token 요청도 동시 호출 시 중복 방지
        let task = await NetworkActor.run { () -> Task<(String, String), Error> in
            if let existingTask = guestTokenTask {
                return existingTask
            }
            
            // 새로운 Guest Token Task 생성
            let newTask = Task<(String, String), Error> {
                let request = await URLRequest(httpMethod: .post, url: .guestToken)
                let response = try await NetworkManager.shared.request(urlRequest: request)
                
                guard let responseData = response.data else { 
                    throw response.error ?? URLError(.badServerResponse) 
                }
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let data = try decoder.decode(Response<LogInResponse>.self, from: responseData).data
                
                return (data.accessToken, data.refreshToken)
            }
            
            guestTokenTask = newTask
            return newTask
        }
        
        do {
            let tokens = try await task.value
            
            // Task 완료 후 정리
            await NetworkActor.run {
                guestTokenTask = nil
            }
            
            return tokens
        } catch {
            // 에러 발생 시에도 Task 정리
            await NetworkActor.run {
                guestTokenTask = nil
            }
            throw error
        }
    }
    
    private func refreshToken() async throws -> (String?, String?) {
        // Task 캐싱 패턴: 동시 요청들이 같은 Task 결과를 공유
        let task = await NetworkActor.run { () -> Task<(String, String), Error> in
            if let existingTask = refreshTokenTask {
                return existingTask
            }
            
            // 새로운 리프레시 Task 생성
            let newTask = Task<(String, String), Error> {
                let tokens = try await SessionManager.shared.requestRefreshToken()
                return tokens
            }
            
            refreshTokenTask = newTask
            return newTask
        }
        
        do {
            let tokens = try await task.value
            
            // Task 완료 후 정리
            await NetworkActor.run {
                refreshTokenTask = nil
            }
            
            return (tokens.0, tokens.1)
        } catch {
            // 에러 발생 시에도 Task 정리
            await NetworkActor.run {
                refreshTokenTask = nil
            }
            throw error
        }
    }
}

// MARK: - NSURLSession Delegate
extension NetworkManager: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        guard handleSSL(session, challenge: challenge), let trust = challenge.protectionSpace.serverTrust else { return (.cancelAuthenticationChallenge, nil) }
        return (.useCredential, URLCredential(trust: trust))
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        session.invalidateAndCancel()
    }
}

// MARK: - Log
#if os(iOS)
extension NetworkManager {

    private func handle(experiment: GrowthBookExperiment?) {
        Task.detached(priority: .background) {
            guard let experiment else { return }
            AmplitudeEvent.name(.setUpExperimentEnv)?
                .properties(experiment.properties)
                .send()
        }
    }
}
#endif
