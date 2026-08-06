//
//  DeeplinkKey.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum DeeplinkKey {
    case site
    case tab
    case isSubTab
    case keyword
    case code
    case couponNumber
    case collection
    case filter
    case sort
    case number
    case url
    case orderNumber
    case contentsProductNumber
    case dealProductNumber
}

extension DeeplinkKey {
    
    var isEditable: Bool {
        switch self {
        case .site:                     false
        case .tab:                      false
        case .isSubTab:                 true
        case .keyword:                  true
        case .code:                     true
        case .couponNumber:             true
        case .collection:               true
        case .filter:                   true
        case .sort:                     true
        case .number:                   true
        case .url:                      true
        case .orderNumber:              true
        case .contentsProductNumber:    true
        case .dealProductNumber:        true
        }
    }
}

extension DeeplinkKey: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .site:                     String(localized: "site")
        case .tab:                      String(localized: "tab")
        case .isSubTab:                 String(localized: "isSubTab")
        case .keyword:                  String(localized: "keyword")
        case .code:                     String(localized: "code")
        case .couponNumber:             String(localized: "couponNumber")
        case .collection:               String(localized: "collection")
        case .filter:                   String(localized: "filter")
        case .sort:                     String(localized: "sort")
        case .number:                   String(localized: "productNumber")
        case .url:                      String(localized: "url")
        case .orderNumber:              String(localized: "orderNumber")
        case .contentsProductNumber:    String(localized: "contentProductNumber")
        case .dealProductNumber:        String(localized: "dealProductNumber")
        }
    }
}

extension DeeplinkKey: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.site.rawValue:                    self = .site
        case Self.tab.rawValue:                     self = .tab
        case Self.isSubTab.rawValue:                self = .isSubTab
        case Self.keyword.rawValue:                 self = .keyword
        case Self.code.rawValue:                    self = .code
        case Self.couponNumber.rawValue:            self = .couponNumber
        case Self.collection.rawValue:              self = .collection
        case Self.filter.rawValue:                  self = .filter
        case Self.number.rawValue:                  self = .number
        case Self.url.rawValue:                     self = .url
        case Self.orderNumber.rawValue:             self = .orderNumber
        case Self.contentsProductNumber.rawValue:   self = .contentsProductNumber
        case Self.dealProductNumber.rawValue:       self = .dealProductNumber
        default:                                    return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .site:                     "site"
        case .tab:                      "tab"
        case .isSubTab:                 "isSubTab"
        case .keyword:                  "keyword"
        case .code:                     "code"
        case .couponNumber:             "counponNo"
        case .collection:               "collection"
        case .filter:                   "filters"
        case .sort:                     "sorted_type"
        case .number:                   "no"
        case .url:                      "url"
        case .orderNumber:              "order_no"
        case .contentsProductNumber:    "contents_product_no"
        case .dealProductNumber:        "deal_product_no"        
        }
    }
}

extension DeeplinkKey: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension DeeplinkKey: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension DeeplinkKey: Equatable {
    
    static func == (lhs: DeeplinkKey, rhs: DeeplinkKey) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension DeeplinkKey {
    
    static var placeholder: DeeplinkKey {
        .keyword
    }
}
#endif
