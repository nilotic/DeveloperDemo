//
//  ServiceHeaderField.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ServiceHeaderField {
    case signature
    case adPageID
    case guestID
    case cpsPartnerID
    case cpsUUID
    case cpsAccess
    case cpsExpires
    case authorization
    case amplitude(ServiceAnalyticsHeaderField)
    case growthbook(GrowthbookHeaderField)
    case serviceAuth
}

extension ServiceHeaderField: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.signature.rawValue:                    self = .signature
        case Self.adPageID.rawValue:                     self = .adPageID
        case Self.guestID.rawValue:                      self = .guestID
        case Self.authorization.rawValue:                self = .authorization
        case Self.cpsPartnerID.rawValue:                 self = .cpsPartnerID
        case Self.cpsUUID.rawValue:                      self = .cpsUUID
        case Self.cpsAccess.rawValue:                    self = .cpsAccess
        case Self.cpsExpires.rawValue:                   self = .cpsExpires
        case Self.amplitude(.deviceID).rawValue:         self = .amplitude(.deviceID)
        case Self.amplitude(.userID).rawValue:           self = .amplitude(.userID)
        case Self.growthbook(.experimentKey).rawValue:   self = .growthbook(.experimentKey)
        case Self.growthbook(.variationID).rawValue:     self = .growthbook(.variationID)
        case Self.serviceAuth.rawValue:        self = .serviceAuth
        default:                            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .signature:               "X-DEMO-SIGNATURE"
        case .adPageID:                "X-DEMO-AD-PAGE-ID"
        case .guestID:                 "X-DEMO-CART-GUEST-ID"
        case .cpsPartnerID:            "X-DEMO-CART-CH-KFPARTNER-ID"
        case .cpsUUID:                 "X-DEMO-CART-CH-UUID"
        case .cpsAccess:               "X-DEMO-CART-CH-ACCESS"
        case .cpsExpires:              "X-DEMO-CART-CH-EXPIRES"
        case .authorization:           "DEMO-AUTH"
        case .amplitude(let field):    field.rawValue
        case .growthbook(let field):   field.rawValue
        case .serviceAuth:        "DEMO-AUTH"
        }
    }
}

extension ServiceHeaderField: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension ServiceHeaderField: Equatable {
    
    static func ==(lhs: ServiceHeaderField, rhs: ServiceHeaderField) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension ServiceHeaderField: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension ServiceHeaderField: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
