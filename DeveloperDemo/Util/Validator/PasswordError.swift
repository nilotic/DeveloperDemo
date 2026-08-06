//
//  PasswordError.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct PasswordError: OptionSet, Error {
    let rawValue: Int

    static let none = PasswordError(rawValue: 0 << 0)
    static let invalidLength = PasswordError(rawValue: 1 << 0)
    static let invalidCombination = PasswordError(rawValue: 1 << 1)
    static let duplicatedNumber = PasswordError(rawValue: 1 << 2)
    
    static let all: PasswordError = [.invalidLength, .invalidCombination, .duplicatedNumber]
}

extension PasswordError: CustomStringConvertible {
    
    var description: String {
        if contains(.invalidLength) {
            String(localized: "passwordLenthGuide")
            
        } else if contains(.invalidCombination) {
            String(localized: "passwordCharacterGuide")
            
        } else if contains(.duplicatedNumber) {
            String(localized: "passwordRepeatedCharacterGuide")
        } else {
            ""
        }
    }
}

extension PasswordError: Identifiable {
    
    var id: Int {
        rawValue
    }
}

extension PasswordError: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension PasswordError: Equatable {
    
    static func == (lhs: PasswordError, rhs: PasswordError) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
