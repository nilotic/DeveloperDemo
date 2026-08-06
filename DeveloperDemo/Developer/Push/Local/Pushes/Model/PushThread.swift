//
//  PushThread.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum PushThread: String, CaseIterable {
    case announcement
    case delivery
    case event
}

extension PushThread: Identifiable {

    var id: String {
        rawValue
    }
}

extension PushThread: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension PushThread: Equatable {
    
    static func == (lhs: PushThread, rhs: PushThread) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension PushThread: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .announcement:     String(localized: "notice")
        case .delivery:         String(localized: "delivery")
        case .event:            String(localized: "event")
        }
    }
}

extension PushThread: Encodable {
   
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        do { try container.encode(rawValue) } catch { throw error }
    }
}
