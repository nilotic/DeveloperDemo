//
//  DeeplinkHost.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum DeeplinkHost {
    case home
    case sale
    case search
    case myPage
    case notice
    case event
    case panel
    case open
    case cart
    case order
    case category
    case collection
    case collectionGroup
    case product
    case gift
    case compose
    case login
    case signup
    case userInfo
    case addresss
    case delivery
    case games
    case applink(ApplinkHost)
    case frequentlyProducts
    case claim
    case pushAlarmSetter
    case vipPrediction
}

extension DeeplinkHost: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.home.rawValue:                self = .home
        case Self.sale.rawValue:                self = .sale
        case Self.search.rawValue:              self = .search
        case Self.myPage.rawValue:             self = .myPage
        case Self.notice.rawValue:              self = .notice
        case Self.event.rawValue:               self = .event
        case Self.open.rawValue:                self = .open
        case Self.cart.rawValue:                self = .cart
        case Self.order.rawValue:               self = .order
        case Self.category.rawValue:            self = .category
        case Self.collection.rawValue:          self = .collection
        case Self.collectionGroup.rawValue:     self = .collectionGroup
        case Self.product.rawValue:             self = .product
        case Self.gift.rawValue:                self = .gift
        case Self.compose.rawValue:             self = .compose
        case Self.login.rawValue:               self = .login
        case Self.signup.rawValue:              self = .signup
        case Self.userInfo.rawValue:            self = .userInfo
        case Self.addresss.rawValue:            self = .addresss
        case Self.delivery.rawValue:            self = .delivery
        case Self.games.rawValue:               self = .games
        case Self.claim.rawValue:               self = .claim
        case Self.pushAlarmSetter.rawValue:     self = .pushAlarmSetter
        case Self.vipPrediction.rawValue:       self = .vipPrediction
        
        case ApplinkHost.service(.development(.none)).rawValue:  self = .applink(.service(.development(.none)))
        case ApplinkHost.service(.stage(.none)).rawValue:        self = .applink(.service(.stage(.none)))
        case ApplinkHost.service(.production).rawValue:          self = .applink(.service(.production))
        case ApplinkHost.blog.rawValue:                    self = .applink(.blog)
        
        default:                                               return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .home:                     "home"
        case .sale:                     "sale"
        case .search:                   "search"
        case .myPage:                  "mypage"
        case .notice:                   "notice"
        case .event:                    "event"
        case .panel:                    "panel"
        case .open:                     "open"
        case .cart:                     "cart"
        case .order:                    "order"
        case .category:                 "category"
        case .collection:               "collection"
        case .collectionGroup:          "collection-groups"
        case .product:                  "product"
        case .gift:                     "gift"
        case .compose:                  "compose"
        case .login:                    "login"
        case .signup:                   "signup"
        case .userInfo:                 "user-info"
        case .addresss:                 "address"
        case .delivery:                 "delivery"
        case .games:                    "games"
        case .frequentlyProducts:       "frequently-products"
        case .claim:                    "claim"
        case .pushAlarmSetter:          "pushAlarmSetter"
        case .vipPrediction:            "vip-prediction"        
        case .applink(let host):        host.rawValue
        }
    }
}

extension DeeplinkHost: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension DeeplinkHost: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension DeeplinkHost: Equatable {
    
    static func ==(lhs: DeeplinkHost, rhs: DeeplinkHost) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension DeeplinkHost {
    
    static var placeholder: DeeplinkHost {
        .home
    }
}
#endif
