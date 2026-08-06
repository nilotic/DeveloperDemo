//
//  ConfirmationPasswordError.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ConfirmationPasswordError: OptionSet, Error {
    let rawValue: Int

    static let none = ConfirmationPasswordError(rawValue: 0 << 0)
    static let invalidLength = ConfirmationPasswordError(rawValue: 1 << 0)
    static let invalidConfirmation = ConfirmationPasswordError(rawValue: 1 << 1)
    
    static let all: ConfirmationPasswordError = [.invalidLength, .invalidConfirmation]
}

extension ConfirmationPasswordError: CustomStringConvertible {
    
    var description: String {
        if contains(.invalidLength) {
            return String(localized: "invalidConfirmationPasswordPlaceholder")
            
        } else if contains(.invalidConfirmation) {
            return "동일한 비밀번호를 입력"
            
        } else {
            return ""
        }
    }
}

extension ConfirmationPasswordError: Identifiable {
    
    var id: Int {
        rawValue
    }
}

extension ConfirmationPasswordError: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension ConfirmationPasswordError: Equatable {
    
    static func == (lhs: ConfirmationPasswordError, rhs: ConfirmationPasswordError) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
