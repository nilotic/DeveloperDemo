//
//  ServiceAnalyticsHeaderField.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ServiceAnalyticsHeaderField {
    case deviceID
    case userID
}

extension ServiceAnalyticsHeaderField: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.deviceID.rawValue:        self = .deviceID
        case Self.userID.rawValue:          self = .userID
        default:                            return nil
        }
    }
        
    var rawValue: String {
        switch self {
        case .deviceID:     "X-DEMO-ANALYTICS-DEVICE-ID"
        case .userID:       "X-DEMO-ANALYTICS-USER-ID"
        }
    }
}

extension ServiceAnalyticsHeaderField: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension ServiceAnalyticsHeaderField: Equatable {
    
    static func == (lhs: ServiceAnalyticsHeaderField, rhs: ServiceAnalyticsHeaderField) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension ServiceAnalyticsHeaderField: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension ServiceAnalyticsHeaderField: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
