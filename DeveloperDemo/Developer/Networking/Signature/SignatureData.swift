//
//  SignatureData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import CommonCrypto
import CryptoKit

@Observable
final class SignatureData {
    
    // MARK: - Value
    // MARK: Public
    // @Published var signature = ""
    var userAgent = ""
    var status: SignatureStatus = .none
    
    private(set) var validationAnimationValue = 0
    private(set) var invalidationAnimationValue = 0
    
    
    // MARK: - Function
    // MARK: Public
    func validate() {
        let components = userAgent.components(separatedBy: " Signature/")
        let userAgent = components.first ?? ""
        let signature = components.last ?? ""
        
        let majorVersion: Int = {
            guard let range = userAgent.range(of: "OS/iOS (") else { return 0 }
            let substring = userAgent[range.upperBound...]
            
            guard let endRange = substring.range(of: ")") else { return 0 }
            return Int(Float(String(substring[..<endRange.lowerBound])) ?? 0)
        }()
        
        let patchVersion: Int = {
            guard let range = userAgent.range(of: "AppVersion/") else { return 0 }
            let substring = userAgent[range.upperBound...]
            
            guard let endRange = substring.range(of: " ") else { return 0 }
            let value = String(substring[..<endRange.lowerBound]).components(separatedBy: ".").last ?? ""
            return Int(Float(String(value)) ?? 0)
        }()
            
        let location = (majorVersion + patchVersion) / 8
        let nonce = String(signature.dropFirst(location).prefix(8))
        
        var result: String {
            guard let nonceData = nonce.data(using: .utf8) else { return "" }
            let key = SHA256.hash(data: nonceData).compactMap { String(format: "%02x", $0) }.joined()

            guard let keyData = key.data(using: .utf8), let userAgentData = userAgent.data(using: .utf8) else { return "" }
            let hmacData = HMAC<SHA256>.authenticationCode(for: userAgentData, using: SymmetricKey(data: keyData))
            let hmac = hmacData.map { String(format: "%02x", $0) }.joined()
            
            return String(hmac.prefix(location)) + nonce + String(hmac.dropFirst(location))
        }
        
        self.status = result == signature ? .valid : .invalid
        animate()
    }
    
    /*func validate() {
        var signature: String {
            guard let data = userAgent.data(using: .utf8) else { return "" }
            let key = SHA512.hash(data: data).compactMap { String(format: "%02x", $0) }.joined()
            
            guard let keyData = key.data(using: .utf8) else { return "" }
            let hmac = HMAC<SHA512>.authenticationCode(for: data, using: SymmetricKey(data: keyData))
            
            return hmac.map { String(format: "%02x", $0) }.joined()
        }
        
        self.status = self.signature == signature ? .valid : .invalid
        animate()
    }*/
    
    // MARK: Private
    private func animate() {
        switch status {
        case .none:      break
        case .invalid:   invalidationAnimationValue += 1
        case .valid:     validationAnimationValue += 1
        }
    }
}
