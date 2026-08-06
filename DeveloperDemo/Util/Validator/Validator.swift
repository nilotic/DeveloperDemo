//
//  Validator.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation
import UIKit

struct Validator {
    
    // MARK: - Value
    static private let alphabetCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    static private let numberCharacterSet = CharacterSet(charactersIn: "0123456789")
    static private let specialCharacterSet = CharacterSet(charactersIn: "\\-/:;()₩&@\".,?!'[]{}#%^*+=_~<>|$£€¥•.,?!'")
    
    
    // MARK: - Function
    static func validate(userID: String?) throws {
        guard let userID, !userID.isEmpty else { throw UserIDError.all }
        
        var isValidLength: Bool {
            SignUpTextInputRules.userIDRange ~= userID.count
        }
        
        var isValidCombination: Bool {
            var isAlphabetContained = false
            var isNumberContained = false
            
            for character in userID {
                guard String(character).rangeOfCharacter(from: .whitespacesAndNewlines) == nil else { return false }
                
                let isAlphabet = String(character).rangeOfCharacter(from: alphabetCharacterSet) != nil
                let isNumber = String(character).rangeOfCharacter(from: numberCharacterSet) != nil
                
                guard isAlphabet || isNumber else { return false }
                isAlphabetContained = isAlphabetContained || isAlphabet
                isNumberContained = isNumberContained || isNumber
            }
            
            return isAlphabetContained || isNumberContained
        }
        
        var error: UserIDError = .none
        if !isValidLength {
            error.insert(.invalidLength)
        }
        
        if !isValidCombination {
            error.insert(.invalidCombination)
        }
        
        guard error == .none else { throw error }
    }
    
    static func validateUserID(input: String) -> Bool {
        input.range(of: #"^[a-zA-Z0-9]{0,16}+$"#, options: .regularExpression) != nil
    }
    
    static func validate(password: String) throws {
        guard !password.isEmpty else { throw PasswordError.all }
        
        var isValidLength: Bool {
            SignUpTextInputRules.passwordRange ~= password.count
        }
        
        var isValidCombination: Bool {
            var isAlphabetContained = false
            var isNumberContained = false
            var isSpecialCharacterContained = false
            
            for character in password {
                guard String(character).rangeOfCharacter(from: .whitespacesAndNewlines) == nil else { return false }
                
                let isAlphabet = String(character).rangeOfCharacter(from: alphabetCharacterSet) != nil
                let isNumber = String(character).rangeOfCharacter(from: numberCharacterSet) != nil
                let isSpecialCharacter = String(character).rangeOfCharacter(from: specialCharacterSet) != nil
                
                guard isAlphabet || isNumber || isSpecialCharacter else { return false }
                isAlphabetContained = isAlphabetContained || isAlphabet
                isNumberContained = isNumberContained || isNumber
                isSpecialCharacterContained = isSpecialCharacterContained || isSpecialCharacter
            }
            
            guard 2 <= [isAlphabetContained, isNumberContained, isSpecialCharacterContained].filter({ $0 }).count else { return false }
            return true
        }
        
        var isDuplicatedNumber: Bool {
            var duplicatedCount = 0
            
            for (i, character) in password.enumerated() {
                guard 0 < i else { continue }
                let previous = password[password.index(password.startIndex, offsetBy: i - 1)]
                
                if previous == character, String(character).rangeOfCharacter(from: numberCharacterSet) != nil {
                    duplicatedCount += 1
                    
                    guard 2 <= duplicatedCount else { continue }
                    return true
                    
                } else {
                    guard duplicatedCount < 3 else { return true }
                    duplicatedCount = 0
                }
            }
            
            return false
        }
        
        var error: PasswordError = .none
        
        if !isValidLength {
            error.insert(.invalidLength)
        }
        
        if !isValidCombination {
            error.insert(.invalidCombination)
        }
        
        if isDuplicatedNumber {
            error.insert(.duplicatedNumber)
        }
        
        guard error == .none else { throw error }
    }
    
    static func validate(password: String, confirmationPassword: String) throws {
        guard !confirmationPassword.isEmpty else { throw ConfirmationPasswordError.invalidLength }
        guard password == confirmationPassword else { throw ConfirmationPasswordError.invalidConfirmation }
    }
    
    static func validatePassword(input: String) -> Bool {
        input.range(of: #"^[a-zA-Z0-9|\-/:;()₩&@\".,?!'\[\]{}#%^*+=_\\~<>\|$£€¥•.,?!']{0,16}+$"#, options: .regularExpression) != nil
    }
    
    static func validateName(input: String, socialType: SocialType) -> Bool {
        switch socialType {
        case .none:     return false
        case .apple:    return input.range(of: #"^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{0,20}+$"#, options: .regularExpression) != nil
        case .kakao, .naver:    return input.range(of: #"^[ㄱ-ㅎㅏ-ㅣ가-힣]{0,20}+$"#, options: .regularExpression) != nil        
        }
    }
    
    static func validate(phoneNumber: String?) -> Bool {
        guard let phoneNumber else { return false }
        return phoneNumber.range(of: #"^\(?\d{3}\)?[ -]?\d{3,4}[ -]?\d{4}$"#, options: .regularExpression) != nil
    }
    
    static func validate(oneTimeCode: String?) -> Bool {
        guard let oneTimeCode else { return false }
        return oneTimeCode.range(of: #"\d{7}$"#, options: .regularExpression) != nil
    }
    
    static func validate(email: String?) -> Bool {
        guard let email = email else { return false }
        return email.range(of: #"^\S+@\S+\.\S+$"#, options: .regularExpression) != nil
    }
}
