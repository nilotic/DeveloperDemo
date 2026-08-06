//
//  HTTPHeaderField.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum HTTPHeaderField {
    case contentType
    case contentLength
    case accept
    case acceptEncoding
    case acceptLanguage
    case userAgent
    case authorization
    case authorizationToken
    case serviceAuthorization
    case origin
    case referer
    case appVersion    
    case amplitude(AmplitudeHeaderField)
    case service(ServiceHeaderField)
}

extension HTTPHeaderField: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.contentType.rawValue:                     self = .contentType
        case Self.contentLength.rawValue:                   self = .contentLength
        case Self.accept.rawValue:                          self = .accept
        case Self.acceptEncoding.rawValue:                  self = .acceptEncoding
        case Self.acceptLanguage.rawValue:                  self = .acceptLanguage
        case Self.userAgent.rawValue:                       self = .userAgent
        case Self.authorization.rawValue:                   self = .authorization
        case Self.authorizationToken.rawValue:              self = .authorizationToken
        case Self.serviceAuthorization.rawValue:              self = .authorization
        case Self.origin.rawValue:                          self = .origin
        case Self.referer.rawValue:                         self = .referer
        case Self.appVersion.rawValue:                      self = .appVersion        
        case Self.amplitude(.sessionID).rawValue:           self = .amplitude(.sessionID)
        case Self.service(.signature).rawValue:               self = .service(.signature)
        case Self.service(.adPageID).rawValue:                self = .service(.adPageID)
        case Self.service(.guestID).rawValue:                 self = .service(.guestID)
        case Self.service(.cpsPartnerID).rawValue:            self = .service(.cpsPartnerID)
        case Self.service(.cpsUUID).rawValue:                 self = .service(.cpsUUID)
        case Self.service(.cpsAccess).rawValue:               self = .service(.cpsAccess)
        case Self.service(.cpsExpires).rawValue:              self = .service(.cpsExpires)
        case Self.service(.authorization).rawValue:           self = .service(.authorization)
        case Self.service(.amplitude(.deviceID)).rawValue:    self = .service(.amplitude(.deviceID))
        case Self.service(.amplitude(.userID)).rawValue:      self = .service(.amplitude(.userID))
        default:                                            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .contentType:              "Content-Type"
        case .contentLength:            "Content-Length"
        case .accept:                   "Accept"
        case .acceptEncoding:           "Accept-Encoding"
        case .acceptLanguage:           "Accept-Language"
        case .userAgent:                "User-Agent"
        case .authorization:            "Authorization"
        case .authorizationToken:       "AuthorizationToken"
        case .serviceAuthorization:       "DEMO-AUTH"
        case .origin:                   "Origin"
        case .referer:                  "Referer"
        case .appVersion:               "appversion"
        case .amplitude(let field):     field.rawValue
        case .service(let field):         field.rawValue
        }
    }
}

extension HTTPHeaderField: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension HTTPHeaderField: Equatable {
    
    static func ==(lhs: HTTPHeaderField, rhs: HTTPHeaderField) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension HTTPHeaderField: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension HTTPHeaderField: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
