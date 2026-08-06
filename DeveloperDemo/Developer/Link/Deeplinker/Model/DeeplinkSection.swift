//
//  DeeplinkSection.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeeplinkSection {
    let title: LocalizedStringKey
    var items: [DeeplinkItem]
    var isExpanded = false
}

extension DeeplinkSection {
    
    var imageName: String {
        guard let absoluteString = items.first?.deeplink.absoluteString else { return "" }
        
        switch absoluteString {
        case let string where string.contains(DeeplinkHost.home.rawValue):                     return "house"
        case let string where string.contains(DeeplinkHost.search.rawValue):                   return "magnifyingglass"
        case let string where string.contains(DeeplinkHost.myPage.rawValue):                  return "person"
        case let string where string.contains(DeeplinkHost.notice.rawValue):                   return "megaphone"
        case let string where string.contains(DeeplinkHost.event.rawValue):                    return "gift"
        case let string where string.contains(DeeplinkHost.games.rawValue):                    return "gamecontroller"
        case let string where string.contains(DeeplinkHost.open.rawValue):                     return "globe"
        case let string where string.contains(DeeplinkHost.cart.rawValue):                     return "cart"
        case let string where string.contains(DeeplinkHost.order.rawValue):                    return "list.clipboard"
        case let string where string.contains(DeeplinkHost.category.rawValue):                 return "shippingbox"
        case let string where string.contains(DeeplinkHost.product.rawValue):                  return "shippingbox"
        case let string where string.contains(DeeplinkHost.gift.rawValue):                     return "gift"
        case let string where string.contains(DeeplinkHost.compose.rawValue):                  return "pencil.line"
        case let string where string.contains(DeeplinkHost.login.rawValue):                    return "person.crop.circle"
        case let string where string.contains(DeeplinkHost.userInfo.rawValue):                 return "person.circle"
        case let string where string.contains(DeeplinkHost.addresss.rawValue):                 return "list.bullet.clipboard"
        case let string where string.contains(DeeplinkHost.delivery.rawValue):                 return "box.truck"
        default:                                                                                    return "network"
        }
    }
}

extension DeeplinkSection: Identifiable {
    
    var id: String {
        "\(title)\(items.map(\.id).joined())\(isExpanded)"
    }
}

extension DeeplinkSection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension DeeplinkSection: Equatable {
    
    static func == (lhs: DeeplinkSection, rhs: DeeplinkSection) -> Bool {
        lhs.id == rhs.id
    }
}

extension DeeplinkSection {
    
    static var home: DeeplinkSection {
        let items = [DeeplinkItem(title: "home", deeplink: Deeplink(host: .home), version: "205.9.1"),
                     DeeplinkItem(title: "\(String(localized: "home")) (\(String(localized: "market")))", deeplink: Deeplink(host: .home, components: [.site: "market"]), version: "205.9.1"),
                     DeeplinkItem(title: "\(String(localized: "home")) (\(String(localized: "beauty")))",  deeplink: Deeplink(host: .home, components: [.site: "beauty"]), version: "205.9.1"),
                     DeeplinkItem(title: "marketSite", deeplink: Deeplink(host: .sale, components: [.site: "market"]), version: "2.40.0"),
                     DeeplinkItem(title: "beautySite", deeplink: Deeplink(host: .sale, components: [.site: "beauty"]), version: "2.40.0"),
                     DeeplinkItem(title: "리빙 탭", deeplink: Deeplink(host: .home, components: [.site: "market", .tab: "living"]), version: "3.62.1"),
                     DeeplinkItem(title: "패션 탭", deeplink: Deeplink(host: .home, components: [.site: "beauty", .tab: "fashion"]), version: "3.62.1"),
                     DeeplinkItem(title: "리빙 패널", deeplink: Deeplink(host: .panel, components: [.site: "market", .code: "living"]), version: "3.62.1"),
                     DeeplinkItem(title: "패션 패널", deeplink: Deeplink(host: .panel, components: [.site: "beauty", .code: "fashion"]), version: "3.62.1")]
        
        return DeeplinkSection(title: "home", items: items)
    }
    
    static var search: DeeplinkSection {
        let items = [DeeplinkItem(title: "search", deeplink: Deeplink(host: .search), version: "2.15.0"),
                     DeeplinkItem(title: "마켓 검색 결과", deeplink: Deeplink(host: .search, components: [.site: "market",
                                                                                                           .keyword: "커피"]), version: "2.15.0"),
                     
                     DeeplinkItem(title: "뷰티 검색 결과", deeplink: Deeplink(host: .search, components: [.site: "beauty",
                                                                                                           .keyword: "LUSH"]), version: "2.15.0")]
                
        return DeeplinkSection(title: "search", items: items)
    }
    
    static var myPage: DeeplinkSection {
        let items = [DeeplinkItem(title: "myPage", deeplink: Deeplink(host: .myPage), version: "205.6.1"),
                     DeeplinkItem(title: "쿠폰 목록", deeplink: Deeplink(host: .myPage, path: .coupon), version: "205.12.4"),
                     
                     DeeplinkItem(title: "쿠폰 등록 + 코드", deeplink: Deeplink(host: .myPage, path: .coupon, components: [.code: "럭셔리위크",
                                                                                                                             .couponNumber: "럭셔리위크"]), version: "205.12.4"),
                     
                     DeeplinkItem(title: "bulkOrder",     deeplink: Deeplink(host: .myPage, path: .bulkOrder), version: "205.34.0"),
                     DeeplinkItem(title: "expectedGrade", deeplink: Deeplink(host: .myPage, path: .benefit),   version: "2.40.0"),
                     DeeplinkItem(title: "pick",          deeplink: Deeplink(host: .myPage, path: .pick),      version: "2.40.0"),
                     DeeplinkItem(title: "points",        deeplink: Deeplink(host: .myPage, path: .emoney),    version: "2.40.0"),
                     DeeplinkItem(title: "자주 사는 상품",    deeplink: Deeplink(host: .frequentlyProducts), version: "3.24.1"),
                     DeeplinkItem(title: "claim", deeplink: Deeplink(host: .claim), version: "3.34.1"),

                     DeeplinkItem(title: "notices", deeplink: Deeplink(host: .notice, components: [.number: "1722"]), version: "2.39.0"),
                     DeeplinkItem(title: "pushAlarmSetter", deeplink: Deeplink(host: .pushAlarmSetter), version: "3.17.0"),
                     DeeplinkItem(title: "vipPrediction", deeplink: Deeplink(host: .vipPrediction), version: "")]
        
        
        return DeeplinkSection(title: "myPage", items: items)
    }
    
    static var event: DeeplinkSection {
        let items = [DeeplinkItem(title: "목록", deeplink: Deeplink(host: .event), version: "205.7.2")]
        return DeeplinkSection(title: "event", items: items)
    }
    
    static var games: DeeplinkSection {
        let items = [DeeplinkItem(title: "데모 팜", deeplink: Deeplink(host: .games, path: .games("my-demo-farm")), version: "3.16.0")]
        return DeeplinkSection(title: "game", items: items)
    }
  
    static var web: DeeplinkSection {
        let items = [DeeplinkItem(title: "웹 페이지", deeplink: Deeplink(host: .open, components: [.url: "https://www.example.com/main"]), version: "205.6.1")]
        return DeeplinkSection(title: "웹 페이지", items: items)
    }
    
    static var cart: DeeplinkSection {
        let items = [DeeplinkItem(title: "cart", deeplink: Deeplink(host: .cart), version: "205.6.1")]
        return DeeplinkSection(title: "cart", items: items)
       
    }
    
    static var order: DeeplinkSection {
        let items = [DeeplinkItem(title: "orderHistory", deeplink: Deeplink(host: .order), version: "3.34.0"),
                     DeeplinkItem(title: "orderDetails", deeplink: Deeplink(host: .order, components: [.number: "2360321580236"]), version: "205.8.1")]
        
        return DeeplinkSection(title: "주문", items: items)
       
    }
    
    static var product: DeeplinkSection {
        let items = [DeeplinkItem(title: "상품", deeplink: Deeplink(host: .category, components: [.number: "209"]), version: "205.6.1"),
                     DeeplinkItem(title: "상품", deeplink: Deeplink(host: .collection, components: [.code: "market-best"]), version: "2.37.0"),
                     DeeplinkItem(title: "상품", deeplink: Deeplink(host: .product, components: [.number: "5063110"]), version: "205.6.0"),
                     DeeplinkItem(title: "목록", deeplink: Deeplink(host: .collectionGroup, path: .collectionGroup("market-best"), components: [.collection: "market-hmr-best"]), version: "3.31.0"),
                     DeeplinkItem(title: "목록", deeplink: Deeplink(host: .collectionGroup, path: .collectionGroup("beauty-best"), components: [.collection: "beauty-best-ranking"]), version: "3.31.0"),
                     
                     DeeplinkItem(title: "목록", deeplink: Deeplink(host: .collectionGroup, path: .collectionGroup("market-best"), components: [.collection: "market-etc-best",
                                                                                                                                                    .filter: "category:919",
                                                                                                                                                    .sort : "2"]), version: "3.31.0"),
                     
                     DeeplinkItem(title: "목록", deeplink: Deeplink(host: .collectionGroup, path: .collectionGroup("beauty-best"), components: [.collection: "beauty-best-luxury",
                                                                                                                                                    .filter: "category:365",
                                                                                                                                                    .sort : "4"]), version: "3.31.0")]
        return DeeplinkSection(title: "goods", items: items)
    }
    
    static var gift: DeeplinkSection {
        let items = [DeeplinkItem(title: "detail", deeplink: Deeplink(host: .gift, path: .detail, components: [.orderNumber: "209"]), version: "2.34.0")]
        return DeeplinkSection(title:"gifts", items: items)
    }
    
    static var compose: DeeplinkSection {
        let items = [DeeplinkItem(title: "reviews", deeplink: Deeplink(host: .compose, path:. review, components: [.contentsProductNumber: "209",
                                                                                                                        .dealProductNumber: "208",
                                                                                                                        .orderNumber : "5063110"]), version: "205.10.0"),
                     
                     DeeplinkItem(title: "oneOnOne", deeplink: Deeplink(host: .compose, path: .inquiry), version: "205.8.1")]
        
        return DeeplinkSection(title: "작성하기", items: items)
    }
    
    static var user: DeeplinkSection {
        let items = [DeeplinkItem(title: "login",      deeplink: Deeplink(host: .login), version: "205.12.4"),
                     DeeplinkItem(title: "editAccount", deeplink: Deeplink(host: .userInfo, path: .edit), version: "3.7.0"),
                     DeeplinkItem(title: "signup",     deeplink: Deeplink(host: .signup), version: "3.17.0")]
        
        return DeeplinkSection(title: "member", items: items)
    }
    
    static var address: DeeplinkSection {
        let items = [DeeplinkItem(title: "관리", deeplink: Deeplink(host: .addresss), version: "3.7.0"),
                     DeeplinkItem(title: "information", deeplink: Deeplink(host: .delivery, path: .guide), version: "3.7.0")]
        
        return DeeplinkSection(title: "deliveryAddress", items: items)
    }
    
    static var universalLink: DeeplinkSection {
        let items = [DeeplinkItem(title: "메인 (뷰티)", deeplink: Deeplink(host: .applink(.service(.production)), path: .main("beauty")), version: "3.13.0"),
                     DeeplinkItem(title: "카테고리", deeplink: Deeplink(host: .applink(.service(.production)), path: .category("909")), version: "3.13.0"),
                     DeeplinkItem(title: "컬렉션", deeplink: Deeplink(host: .applink(.service(.production)), path: .collection("0317-rush")), version: "3.13.0"),
                     DeeplinkItem(title: "상품 상세", deeplink: Deeplink(host: .applink(.service(.production)), path: .goods("1000146194")), version: "3.13.0"),
                     DeeplinkItem(title: "blog", deeplink: Deeplink(host: .applink(.blog), path: .post("BGPx-uFvd")), version: "3.23.0"),
                     
                     DeeplinkItem(title: "리빙 탭", deeplink: Deeplink(host: .applink(.service(.production)), path: .panels("living"), components: [.isSubTab: "true"]), version: "3.63.1"),
                     DeeplinkItem(title: "패션 탭", deeplink: Deeplink(host: .applink(.service(.production)), path: .panels("fashion"), components: [.isSubTab: "true"]), version: "3.63.1"),

                     DeeplinkItem(title: "마켓-리빙 탭", deeplink: Deeplink(host: .applink(.service(.stage(.none))), path: .panels("living"),
                                                                            components: [.isSubTab: "true", .site: "market"]), version: "3.63.1"),
                     
                     DeeplinkItem(title: "패션-뷰티 탭", deeplink: Deeplink(host: .applink(.service(.stage(.none))), path: .panels("fashion"),
                                                                            components: [.isSubTab: "true", .site: "beauty"]), version: "3.63.1"),
        
                     DeeplinkItem(title: "리빙관", deeplink: Deeplink(host: .applink(.service(.stage(.none))), path: .panels("living"), components: [.site: "market"]), version: "3.63.1"),
                     DeeplinkItem(title: "패션관", deeplink: Deeplink(host: .applink(.service(.stage((.none)))), path: .panels("fashion"), components: [.site: "beauty"]), version: "3.63.1")]
        
        return DeeplinkSection(title: "universalLink", items: items)
    }
}

#if DEBUG
extension DeeplinkSection {
    
    static var placeholder: DeeplinkSection {
        home
    }
}
#endif
