//
//  AuthorizationScheme.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum AuthorizationScheme {
    case basic              // https://datatracker.ietf.org/doc/html/rfc7617
    case bearer             // https://datatracker.ietf.org/doc/html/rfc6750
    case digest             // https://datatracker.ietf.org/doc/html/rfc7616
    case hoba               // https://datatracker.ietf.org/doc/html/rfc7486
    case mutual             // https://datatracker.ietf.org/doc/html/rfc8120
    case ntlm               // https://datatracker.ietf.org/doc/html/rfc4559
    case vapid              // https://datatracker.ietf.org/doc/html/rfc8292
    case scram              // https://datatracker.ietf.org/doc/html/rfc7804
    case aws4HMACSHA256     // https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-auth-using-authorization-header.html
    case service
}

extension AuthorizationScheme: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.basic.rawValue:               self = .basic
        case Self.bearer.rawValue:              self = .bearer
        case Self.digest.rawValue:              self = .digest
        case Self.hoba.rawValue:                self = .hoba
        case Self.mutual.rawValue:              self = .mutual
        case Self.ntlm.rawValue:                self = .ntlm
        case Self.vapid.rawValue:               self = .vapid
        case Self.scram.rawValue:               self = .scram
        case Self.aws4HMACSHA256.rawValue:      self = .aws4HMACSHA256
        case Self.service.rawValue:               self = .service
        default:                                return nil
        }
    }
        
    var rawValue: String {
        switch self {
        case .basic:            "Basic"
        case .bearer:           "Bearer"
        case .digest:           "Digest"
        case .hoba:             "HOBA"
        case .mutual:           "Mutual"
        case .ntlm:             "NTLM"
        case .vapid:            "VAPID"
        case .scram:            "SCRAM"
        case .aws4HMACSHA256:   "AWS4-HMAC-SHA256"
        case .service:            "Demo"
        }
    }
}

extension AuthorizationScheme: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension AuthorizationScheme: Equatable {
    
    static func == (lhs: AuthorizationScheme, rhs: AuthorizationScheme) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension AuthorizationScheme: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension AuthorizationScheme: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
