//
//  Site.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum Site: String, Codable {
    case market
    case beauty

    var isMarket: Bool {
        self == .market
    }

    var switchedSite: Self {
        .market == self ? .beauty : .market
    }
    
    var siteName: String {
        switch self {
        case .market:   "데모마켓"
        case .beauty:   "데모뷰티"
        }
    }

    static let `default` = Site.market
}

extension Site: Identifiable {
    var id: String {
        rawValue
    }
}

extension Site: CaseIterable {
}
