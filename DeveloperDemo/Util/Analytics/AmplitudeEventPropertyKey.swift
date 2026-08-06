//
//  AmplitudeEventPropertyKey.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum AmplitudeEventPropertyKey {
    case deviceID
    case cause
    case detailedCause
    case jwt
    case experimentID
    case variationID
}

extension AmplitudeEventPropertyKey: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: self))
    }
}

extension AmplitudeEventPropertyKey: Equatable {

    static func ==(lhs: AmplitudeEventPropertyKey, rhs: AmplitudeEventPropertyKey) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
