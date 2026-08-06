//
//  AmplitudeHeaderField.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum AmplitudeHeaderField {
    case sessionID
}

extension AmplitudeHeaderField: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.sessionID.rawValue:       self = .sessionID
        default:                            return nil
        }
    }
        
    var rawValue: String {
        switch self {
        case .sessionID:    "amplitude-session-id"
        }
    }
}

extension AmplitudeHeaderField: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension AmplitudeHeaderField: Equatable {
    
    static func == (lhs: AmplitudeHeaderField, rhs: AmplitudeHeaderField) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension AmplitudeHeaderField: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension AmplitudeHeaderField: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
