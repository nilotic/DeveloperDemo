//
//  URLRequestExtension.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit
import Foundation
import CommonCrypto
import CryptoKit
import AdSupport
import AppTrackingTransparency

extension URLRequest {
    
    init(httpMethod: HTTPMethod, url: ServiceURL) async {
        self.init(url: url.rawValue)
        
        // Set request
        self.httpMethod = httpMethod.rawValue
        
        guard let host = url.rawValue.host else {
            return
        }
        
        guard hosts.api.rawValue.contains(host) ||
              hosts.eventConfiguration.rawValue.contains(host) ||
              hosts.authentication.rawValue.contains(host) else {
            return
        }
        set(value: .application(.json), field: .contentType)
        set(value: .application(.json), field: .accept)
        set(value: "gzip",field: .acceptEncoding)
        set(value: userAgent, field: .userAgent)
        set(value: VersionManager.shared.shortVersionString, field: .appVersion)
        set(value: AmplitudeManager.shared.deviceID, field: .service(.amplitude(.deviceID)))
        set(value: AmplitudeManager.shared.userID, field: .service(.amplitude(.userID)))
            
        guard let token = await TokenManager.shared.accessToken else { return }
        set(value: token, field: HTTPHeaderField.serviceAuthorization)
    }
        
    init(httpMethod: HTTPMethod, url: URL) {
        self.init(url: url)
        
        // Set request
        self.httpMethod = httpMethod.rawValue
    }
    
    init(url: URL, httpMethod: HTTPMethod) async {
        self.init(url: url)
        
        // Set request
        self.httpMethod = httpMethod.rawValue
        
        guard let host = url.host else {
            return
        }
        
        guard hosts.api.rawValue.contains(host) ||
              hosts.eventConfiguration.rawValue.contains(host) ||
              hosts.authentication.rawValue.contains(host) else {
            return
        }
        set(value: .application(.json), field: .contentType)
        set(value: .application(.json), field: .accept)
        set(value: "gzip",field: .acceptEncoding)
        set(value: userAgent, field: .userAgent)
        set(value: VersionManager.shared.shortVersionString, field: .appVersion)
                
        guard let token = await TokenManager.shared.accessToken else { return }
        set(value: token, field: HTTPHeaderField.serviceAuthorization)
    }
}

extension URLRequest {
    
    // OS/iOS (16.4) AppVersion/300.17.4 (0) Device/x86_64 Demo/3.17.4 (0) DeviceID/F5C19A72-41A7-4CBC-BC20-4EA934757981
    private var userAgent: String {
        let systemVersion = UIDevice.current.systemVersion
        let appVersion = VersionManager.shared.shortVersionString
        var userAgent = "OS/iOS (\(systemVersion)) AppVersion/\(appVersion) Device/\(UIDevice.current.identifier)"
        
        #if targetEnvironment(simulator)
        #else
            if ATTrackingManager.trackingAuthorizationStatus == .authorized {
                userAgent.append(" ADID/\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)")
            }
        #endif
        
        userAgent.append(" Demo/\(VersionManager.shared.versionString) DeviceID/\(PushManager.shared.pushDeviceID)")
        
        
        // Signature
        var signature: String {
            let nonce = UUID().uuidString.components(separatedBy: "-").first ?? ""
            
            guard let nonceData = nonce.data(using: .utf8) else { return "" }
            let key = SHA256.hash(data: nonceData).compactMap { String(format: "%02x", $0) }.joined()

            guard let keyData = key.data(using: .utf8), let userAgentData = userAgent.data(using: .utf8) else { return "" }
            let hmacData = HMAC<SHA256>.authenticationCode(for: userAgentData, using: SymmetricKey(data: keyData))
            let hmac = hmacData.map { String(format: "%02x", $0) }.joined()
            
            let majorVersion = Int(Float(systemVersion) ?? 0)
            let patchVersion = Int(Float(appVersion.components(separatedBy: " ").first?.components(separatedBy: ".").last  ?? "") ?? 0)
            let location = (majorVersion + patchVersion) / 8
            
            return String(hmac.prefix(location)) + nonce + String(hmac.dropFirst(location))
        }
        
        userAgent.append(" Signature/\(signature)")
        return userAgent
    }
    
    /*private var signature: String {
        guard let data = userAgent.data(using: .utf8) else { return "" }
        let key = SHA512.hash(data: data).compactMap { String(format: "%02x", $0) }.joined()
        
        guard let keyData = key.data(using: .utf8) else { return "" }
        let hmac = HMAC<SHA512>.authenticationCode(for: data, using: SymmetricKey(data: keyData))
        
        return hmac.map { String(format: "%02x", $0) }.joined()
    }*/
}

extension URLRequest {
    
    mutating func set(value: HTTPHeaderValue, field: HTTPHeaderField) {
        setValue(value.rawValue, forHTTPHeaderField: field.rawValue)
    }
    
    mutating func set(value: String, field: HTTPHeaderField) {
        setValue(value, forHTTPHeaderField: field.rawValue)
    }
    
    mutating func set(value: HTTPAuthorization) {
        switch value.scheme {
        case .service:    setValue(value.rawValue, forHTTPHeaderField: HTTPHeaderField.service(.authorization).rawValue)
        default:        setValue(value.rawValue, forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }
    }
    
    mutating func add(value: HTTPHeaderValue, field: HTTPHeaderField) {
        addValue(value.rawValue, forHTTPHeaderField: field.rawValue)
    }
    
    mutating func add(value: String, field: HTTPHeaderField) {
        addValue(value, forHTTPHeaderField: field.rawValue)
    }
    
    mutating func remove(field: HTTPHeaderField) {
        setValue(nil, forHTTPHeaderField: field.rawValue)
    }
    
    func value(field: HTTPHeaderField) -> String? {
        value(forHTTPHeaderField: field.rawValue)
    }
}
 
extension URLRequest {
    
    var debugDescription: String {
        """
        Request
        URL
        \(httpMethod ?? "") \(url?.absoluteString ?? "")\n
        HeaderField
        \(allHTTPHeaderFields?.debugDescription ?? "")\n
        Body
        \(String(data: httpBody ?? Data(), encoding: .utf8) ?? "")
        \n\n
        """
    }
}
