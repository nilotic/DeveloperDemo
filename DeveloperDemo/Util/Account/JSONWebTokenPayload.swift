//
//  JSONWebTokenPayload.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct JSONWebTokenPayload {
    let issuer: String
    let subject: String?
    let issuedAt: TimeInterval
    let expirationTime: TimeInterval
    let notBefore: TimeInterval?
    let jsonWebTokenID: String
    let memberID: String
    let memberNumber: Int?
    let email: String   // Apple Credential
    let level: Int?
    let uuid: UUID?
    let userSegment: String?
    let cartID: String
    let isGuest: Bool
}

extension JSONWebTokenPayload: RawRepresentable {
    
    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8), let payload = try? JSONDecoder().decode(JSONWebTokenPayload.self, from: data) else { return nil }
        self = payload
    }
    
    var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        
        guard let data = try? encoder.encode(self), let string = String(data: data, encoding: .utf8) else { return "" }
        return string
    }
}

extension JSONWebTokenPayload: CustomStringConvertible {
    
    var description: String {
        rawValue
    }
}

extension JSONWebTokenPayload: Codable {
    
    private enum Key: String, CodingKey {
        case issuer = "iss"
        case subject = "sub"
        case issuedAt = "iat"
        case expirationTime = "exp"
        case notBefore = "nbf"
        case jsonWebTokenID = "jti"
        case memberID = "m_id"
        case memberNumber = "m_no"
        case email
        case level = "level"
        case uuid = "uuid"
        case userSegment = "m_seg"
        case cartID = "cart_id"
        case isGuest = "is_guest"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(issuer, forKey: .issuer) } catch { throw error }
        do { try container.encode(subject, forKey: .subject) } catch { throw error }
        do { try container.encode(issuedAt, forKey: .issuedAt) } catch { throw error }
        do { try container.encode(expirationTime, forKey: .expirationTime) } catch { throw error }
        do { try container.encode(isGuest, forKey: .isGuest) } catch { throw error }
        
        if let notBefore {
            do { try container.encode(notBefore, forKey: .notBefore) } catch { throw error }
        }
        
        if !jsonWebTokenID.isEmpty {
            do { try container.encode(jsonWebTokenID, forKey: .jsonWebTokenID) } catch { throw error }
        }
        
        if !memberID.isEmpty {
            do { try container.encode(memberID, forKey: .memberID) } catch { throw error }
        }
        
        if let memberNumber {
            do { try container.encode(memberNumber, forKey: .memberNumber) } catch { throw error }
        }
        
        if !email.isEmpty {
            do { try container.encode(email, forKey: .email) } catch { throw error }
        }
        
        if let level {
            do { try container.encode(level, forKey: .level) } catch { throw error }
        }
        
        if let uuid {
            do { try container.encode(uuid.uuidString, forKey: .uuid) } catch { throw error }
        }
        
        if let userSegment {
            do { try container.encode(userSegment, forKey: .userSegment) } catch { throw error }
        }
        
        if !cartID.isEmpty {
            do { try container.encode(cartID, forKey: .cartID) } catch { throw error }
        }
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
    
        do { issuer = try container.decode(String.self, forKey: .issuer) } catch { throw error }
        do { subject = try container.decode(String.self, forKey: .subject) } catch { subject = "" }
        do { issuedAt = try container.decode(TimeInterval.self, forKey: .issuedAt) } catch { throw error }
        do { expirationTime = try container.decode(TimeInterval.self, forKey: .expirationTime) } catch { throw error }
        do { notBefore = try container.decode(TimeInterval.self, forKey: .notBefore) } catch { notBefore = nil }
        do { jsonWebTokenID = try container.decode(String.self, forKey: .jsonWebTokenID) } catch { jsonWebTokenID = "" }
        do { memberID = try container.decode(String.self, forKey: .memberID) } catch { memberID = "" }
        do { memberNumber = try container.decode(Int.self, forKey: .memberNumber) } catch { memberNumber = nil }
        do { email = try container.decode(String.self, forKey: .email) } catch { email = "" }
        do { level = try container.decode(Int.self, forKey: .level) } catch { level = nil  }
        do { uuid = try container.decode(UUID.self, forKey: .uuid) } catch { uuid = nil }
        do { userSegment = try container.decode(String.self, forKey: .userSegment) } catch { userSegment = nil }
        do { cartID = try container.decode(String.self, forKey: .cartID) } catch { cartID = "" }
        do { isGuest = try container.decode(Bool.self, forKey: .isGuest) } catch { isGuest = false }
    }
}
