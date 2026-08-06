//
//  UserIDError.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct UserIDError: OptionSet, Error {
    let rawValue: Int

    static let none = UserIDError(rawValue: 0 << 0)
    static let invalidLength = UserIDError(rawValue: 1 << 0)
    static let invalidCombination = UserIDError(rawValue: 1 << 1)
    static let disconfirmation = UserIDError(rawValue: 1 << 2)
    
    static let all: UserIDError = [.invalidLength, .invalidCombination, .disconfirmation]
}

extension UserIDError: CustomStringConvertible {
    
    var description: String {
        if contains(.invalidLength) {
            return String(localized: "idCombinationGuide")
            
        } else if contains(.invalidCombination) {
            return String(localized: "idCombinationGuide")
            
        } else if contains(.disconfirmation) {
            return String(localized: "idDuplicationValidation")
            
        } else {
            return ""
        }
    }
}

extension UserIDError: Identifiable {
    
    var id: Int {
        rawValue
    }
}

extension UserIDError: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension UserIDError: Equatable {
    
    static func == (lhs: UserIDError, rhs: UserIDError) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
