//
//  GrowthbookHeaderField.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum GrowthbookHeaderField {
    case experimentKey
    case variationID
}

extension GrowthbookHeaderField: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.experimentKey.rawValue:   self = .experimentKey
        case Self.variationID.rawValue:     self = .variationID
        default:                            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .experimentKey:     "X-Demo-Experiment-Experiment-Key"
        case .variationID:       "X-Demo-Experiment-Variation-Id"
        }
    }
}

extension GrowthbookHeaderField: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension GrowthbookHeaderField: Equatable {
    
    static func == (lhs: GrowthbookHeaderField, rhs: GrowthbookHeaderField) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension GrowthbookHeaderField: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension GrowthbookHeaderField: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
