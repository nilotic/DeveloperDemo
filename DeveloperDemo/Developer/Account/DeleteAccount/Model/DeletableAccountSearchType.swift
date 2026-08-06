//
//  DeletableAccountSearchType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

enum DeletableAccountSearchType: CaseIterable {
    case userID
    case userNumber
    case email
    case phoneNumber
}

extension DeletableAccountSearchType {
    
    var title: String {
        switch self {
        case .userID:           String(localized: "id")
        case .userNumber:       String(localized: "userNumber")
        case .email:            String(localized: "email")
        case .phoneNumber:      String(localized: "mobilePhone")
        }
    }
    
    var placeholder: String {
        switch self {
        case .userID:           String(localized: "idPlaceholder")
        case .userNumber:       String(localized: "userNumberPlaceholder")
        case .email:            String(localized: "emailPlaceholder")
        case .phoneNumber:      String(localized: "phoneNumberTextFieldPlaceholder")
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .userID:           .asciiCapable
        case .userNumber:       .numbersAndPunctuation
        case .email:            .emailAddress
        case .phoneNumber:      .numbersAndPunctuation
        }
    }
}

extension DeletableAccountSearchType: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.userID.rawValue:          self = .userID
        case Self.userNumber.rawValue:      self = .userNumber
        case Self.email.rawValue:           self = .email
        case Self.phoneNumber.rawValue:     self = .phoneNumber
        default:                            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .userID:           "MEMBER_ID"
        case .userNumber:       "MEMBER_NO"
        case .email:            "EMAIL"
        case .phoneNumber:      "MOBILE"
        }
    }
}

extension DeletableAccountSearchType: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension DeletableAccountSearchType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension DeletableAccountSearchType: Equatable {
    
    static func ==(lhs: DeletableAccountSearchType, rhs: DeletableAccountSearchType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension DeletableAccountSearchType: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        do { try container.encode(rawValue) } catch { throw error }
    }
}
