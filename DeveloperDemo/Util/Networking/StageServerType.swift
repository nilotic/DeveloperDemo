//
//  StageServerType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum StageServerType: String {
    case none
    case qa1
    case qa2
    case qa3
    case qa4
    case qa5
}

extension StageServerType: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension StageServerType: Equatable {
    
    static func == (lhs: StageServerType, rhs: StageServerType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension StageServerType: CustomDebugStringConvertible {

    var debugDescription: String {
        #if DEBUG || BETA
            switch self {
            case .none:     ""
            case .qa1:      "QA 1"
            case .qa2:      "QA 2"
            case .qa3:      "QA 3"
            case .qa4:      "QA 4"
            case .qa5:      "QA 5"
            }

        #else
            ""
        #endif
    }
}
