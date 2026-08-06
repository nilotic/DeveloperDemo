//
//  HostSettingType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum HostSettingType: String, CaseIterable {
    case development
    case stage
    case perf
    case production
}

extension HostSettingType {
    
    var server: Server {
        switch self {
        case .development:      .development(.none)
        case .stage:            .stage(.none)
        case .perf:             .perf
        case .production:       .production
        }
    }
}

extension HostSettingType: Identifiable {

    var id: String {
        rawValue
    }
}

extension HostSettingType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension HostSettingType: Equatable {
    
    static func == (lhs: HostSettingType, rhs: HostSettingType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension HostSettingType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .development:      "Development"
        case .stage:            "Stage"
        case .perf:             "Perf"
        case .production:       "Production"
        }
    }
}

extension HostSettingType: CustomDebugStringConvertible {
    
    var debugDescription: String {
        switch self {
        case .development:      "Development"
        case .stage:            "Stage"
        case .perf:             "Perf"
        case .production:       "Production"
        }
    }
}
