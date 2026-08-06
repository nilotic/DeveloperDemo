//
//  TextFieldAlert.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

enum TextFieldAlert: String {
    case none
    case keyword
    case coupon
    case number
    case code
    case url
    case orderNumber
    case review
    case category
    case collection
    case goods
    case games
}

extension TextFieldAlert {
    
    var title: String {
        switch self {
        case .none:         ""
        case .keyword:      String(localized: "keyword")
        case .coupon:       String(localized: "coupon")
        case .number:       String(localized: "number")
        case .code:         String(localized: "code")
        case .url:          String(localized: "url")
        case .orderNumber:  String(localized: "orderNumber")
        case .review:       String(localized: "review")
        case .category:     String(localized: "category")
        case .collection:   String(localized: "collection")
        case .goods:        String(localized: "goods")
        case .games:        String(localized: "game")
        }
    }
}

extension TextFieldAlert: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension TextFieldAlert: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension TextFieldAlert: Equatable {
    
    static func ==(lhs: TextFieldAlert, rhs: TextFieldAlert) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension TextFieldAlert {
    
    static var placeholder: TextFieldAlert {
        .keyword
    }
}
#endif
