//
//  RemotePushCategory.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

/// The notification’s type. This string must correspond to the identifier of one of the UNNotificationCategory objects you register at launch time. 
enum RemotePushCategory: String, CaseIterable {
    case market
    case beauty
    case game
}

extension RemotePushCategory: Identifiable {

    var id: String {
        rawValue
    }
}

extension RemotePushCategory: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension RemotePushCategory: Equatable {
    
    static func == (lhs: RemotePushCategory, rhs: RemotePushCategory) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension RemotePushCategory: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .market:     String(localized: "market")
        case .beauty:     String(localized: "beauty")
        case .game:       String(localized: "game")
        }
    }
}

extension RemotePushCategory: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        do { try container.encode(rawValue) } catch { throw error }
    }
}
