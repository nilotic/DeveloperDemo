//
//  GooglePlaygroundOAuthCoordinator.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

@preconcurrency
import WebKit
import OSLog

@MainActor
final class GooglePlaygroundOAuthViewCoordinator: NSObject {
    
    // MARK: - Value
    // MARK: Private
    private let scope: GooglePlaygroundOAuthScope
    private let completion: ((FirebaseToken) -> Void)?
    
    
    // MARK: - Initializer
    init(scope: GooglePlaygroundOAuthScope, completion: ((FirebaseToken) -> Void)?) {
        self.scope = scope
        self.completion = completion
    }
    
    
    // MARK: - Function
    // MARK: Private
    private func handle(url: URL?, cookies: [HTTPCookie]) {
        guard let url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return }
        
        let queries = queryItems.reduce([String: String]()) { result, queryItem  in
            var result = result
            result[queryItem.name] = queryItem.value
            return result
        }
        
        guard components.host == Host.googleDeveloper.rawValue, components.path == "/oauthplayground/",
            Set(scope.queryValue.components(separatedBy: " ")) == Set(queries["scope"]?.components(separatedBy: " ") ?? []) else { return }
        request(code: queries["code"], cookies: cookies)
    }
    
    private func request(code: String?, cookies: [HTTPCookie]) {
        Task {
            guard let code else { return }
            let requestData = FirebaseTokenRequest(code: code, tokenURI: URL(string: "https://oauth2.googleapis.com/token")!)
            
            var request = await URLRequest(httpMethod: .post, url: .googleOAuthPlayground)
            request.setValue(Host.googleDeveloper.rawValue, forHTTPHeaderField: "Host")
            request.setValue("application/json, text/javascript, */*; q=0.01", forHTTPHeaderField: "Accept")
            request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
            request.setValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
            request.setValue("ko-KR,ko;q=0.9", forHTTPHeaderField: "Accept-Language")
            request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
            request.setValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("https://\(Host.googleDeveloper.rawValue)", forHTTPHeaderField: "Origin")
            request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
            request.setValue("https://\(Host.googleDeveloper.rawValue)/oauthplayground/?code=\(requestData.code)&scope=\(scope.rawValue)", forHTTPHeaderField: "Referer")
            request.setValue("keep-alive", forHTTPHeaderField: "Connection")
            request.setValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")
            request.setValue("\(try JSONEncoder().encode(requestData).count)", forHTTPHeaderField: "Content-length")
            request.setValue(cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }, forHTTPHeaderField: "Cookie")
            
            do {
                let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)
                
                guard let data = response.data else { return }
                let responseData = try JSONDecoder().decode(FirebaseTokenResponse.self, from: data)
                
                await MainActor.run { completion?(FirebaseToken(data: responseData)) }
        
            } catch {
                #if DEBUG
                Logger(subsystem: "Firebase", category: "OAuth Playground").error("\(error.localizedDescription)")
                #endif
            }
        }
    }
}

// MARK: - WKNavigation Delegate
extension GooglePlaygroundOAuthViewCoordinator: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        preferences.preferredContentMode = .mobile
        decisionHandler(.allow, preferences)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
            self?.handle(url: webView.url, cookies: cookies)
        }
    }
}
