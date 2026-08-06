//
//  SignUpTextInputRules.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct SignUpTextInputRules {
    static let userIDRange: ClosedRange = 6...16
    static let passwordRange: ClosedRange = 10...16
    static let phoneNumberRange: ClosedRange = 10...11
    static let oneTimeCodeRange: ClosedRange = 0...7
}
