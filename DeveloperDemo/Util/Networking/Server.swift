//
//  Server.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum Server {
    case development(DevelopmentServerType)
    case stage(StageServerType)
    case perf
    case twoCC
    case custom(String)
    case production
}

extension Server {

    var isCustom: Bool {
        switch self {
        case .custom:   true
        default:            false
        }
    }
}

extension Server: RawRepresentable {
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "-")
        
        guard let first = components.first else { return nil }
        switch first {
        case let string where string.contains(Self.development(.none).rawValue):
            self = .development(DevelopmentServerType(rawValue: components.last ?? "") ?? .none)
            
        case let string where string.contains(Self.stage(.none).rawValue):
            self = .stage(StageServerType(rawValue: components.last ?? "") ?? .none)

        case Self.perf.rawValue:
            self = .perf
            
        case Self.twoCC.rawValue:
            self = .twoCC
            
        case Self.production.rawValue:
            self = .production
            
        case let string where string.contains("api"):
            self = .custom(string)
        
        default:
            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .development(let type):      "Development-\(type.rawValue)"
        case .stage(let type):            "Stage-\(type.rawValue)"
        case .perf:                       "Perf"
        case .twoCC:                      "2CC"
        case .custom(let host):           "Custom-\(host)"
        case .production:                 "Production"
        }
    }
}

extension Server: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension Server: Equatable {

    static func == (lhs: Server, rhs: Server) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension Server: CustomDebugStringConvertible {

    var debugDescription: String {
        #if DEBUG || BETA
            switch self {
            case .development(let type):      "Development \(type != .none ? "(\(type.debugDescription))" : "")"
            case .stage(let type):            "Stage \(type != .none ? "(\(type.debugDescription))" : "")"
            case .perf:                       "Perf"
            case .twoCC:                      "2CC"
            case .custom:                     "Custom"
            case .production:                 "Production"
            }

        #else
            ""
        #endif
    }
}
