//
//  DeeplinkPath.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum DeeplinkPath {
    case coupon
    case bulkOrder
    case benefit
    case pick
    case emoney
    case detail
    case review
    case inquiry
    case edit
    case guide
    case main(String)
    case panels(String)
    case category(String)
    case collection(String)
    case collectionGroup(String)
    case goods(String)
    case games(String)
    case post(String)
    case dynamicLink(String)
}

extension DeeplinkPath {
    
    var isEditable: Bool {
        switch self {
        case .category:         true
        case .collection:       true
        case .collectionGroup:  true
        case .goods:            true
        case .games:            true
        default:                false
        }
    }
    
    var type: String {
        switch self {
        case .coupon:           "coupon"
        case .bulkOrder:        "bulk_order"
        case .benefit:          "benefit"
        case .pick:             "pick"
        case .emoney:           "emoney"
        case .detail:           "detail"
        case .review:           "review"
        case .inquiry:          "inquiry"
        case .edit:             "edit"
        case .guide:            "guide"
        case .main:             "main"
        case .panels:           "panels"
        case .category:         "categories"
        case .collection:       "collections"
        case .collectionGroup:  "collection-groups"
        case .goods:            "goods"
        case .games:            "games"
        case .post:             "post"
        case .dynamicLink:      "dynamicLink"
        }
    }
}

extension DeeplinkPath: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .coupon:           String(localized: "coupon")
        case .bulkOrder:        String(localized: "bulkOrder")
        case .benefit:          String(localized: "expectedGrade")
        case .pick:             String(localized: "pick")
        case .emoney:           String(localized: "points")
        case .detail:           String(localized: "detail")
        case .review:           String(localized: "review")
        case .inquiry:          String(localized: "inquiry")
        case .edit:             String(localized: "modify")
        case .guide:            String(localized: "guide")
        case .main:             String(localized: "main")
        case .panels:           String(localized: "panels")
        case .category:         String(localized: "category")
        case .collection:       String(localized: "collection")
        case .collectionGroup:  String(localized: "collectionGroup")
        case .goods:            String(localized: "productDetail")
        case .games:            String(localized: "game")
        case .post:             String(localized: "post")
        case .dynamicLink:      String(localized: "dynamicLink")
        }
    }
}

extension DeeplinkPath: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.coupon.rawValue:                                self = .coupon
        case Self.bulkOrder.rawValue:                             self = .bulkOrder
        case Self.benefit.rawValue:                               self = .benefit
        case Self.pick.rawValue:                                  self = .pick
        case Self.emoney.rawValue:                                self = .emoney
        case Self.detail.rawValue:                                self = .detail
        case Self.review.rawValue:                                self = .review
        case Self.inquiry.rawValue:                               self = .inquiry
        case Self.edit.rawValue:                                  self = .edit
        case Self.guide.rawValue:                                 self = .guide
        case let path where path.contains("main"):                self = .main(path.components(separatedBy: "main/").last ?? "")
        case let path where path.contains("panels"):              self = .panels(path.components(separatedBy: "panels/").last ?? "")
        case let path where path.contains("categories"):          self = .category(path.components(separatedBy: "categories/").last ?? "")
        case let path where path.contains("collections"):         self = .collection(path.components(separatedBy: "collections/").last ?? "")
        case let path where path.contains("collection-groups"):   self = .collection(path.components(separatedBy: "collection-groups/").last ?? "")
        case let path where path.contains("goods"):               self = .goods(path.components(separatedBy: "goods/").last ?? "")
        default:                                                  return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .coupon:                       "coupon"
        case .bulkOrder:                    "bulk_order"
        case .benefit:                      "benefit"
        case .pick:                         "pick"
        case .emoney:                       "emoney"
        case .detail:                       "detail"
        case .review:                       "review"
        case .inquiry:                      "inquiry"
        case .edit:                         "edit"
        case .guide:                        "guide"
        case .main(let site):               "main/\(site)"
        case .panels(let path):             "panels/\(path)"
        case .category(let category):       "categories/\(category)"
        case .collection(let collection):   "collections/\(collection)"
        case .collectionGroup(let path):    path
        case .goods(let goods):             "goods/\(goods)"
        case .games(let game):              game
        case .post(let post):               "p/\(post)"        
        case .dynamicLink(let path):        path
        }
    }
}

extension DeeplinkPath: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension DeeplinkPath: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension DeeplinkPath: Equatable {
    
    static func ==(lhs: DeeplinkPath, rhs: DeeplinkPath) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension DeeplinkPath {
    
    static var placeholder: DeeplinkPath {
        .coupon
    }
}
#endif
