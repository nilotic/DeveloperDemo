//
//  DeeplinkItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeeplinkItem {
    let title: String
    var deeplink: Deeplink
    let version: String
}

extension DeeplinkItem {
    
    var isEditable: Bool {
        var isEditable = !(deeplinkKeys.filter { $0.isEditable }.isEmpty)
     
        if let path = deeplink.path {
            isEditable = isEditable || path.isEditable
        }
        
        return isEditable
    }
    
    var deeplinkKeys: [DeeplinkKey] {
        deeplink.components?.keys.map({ $0 }) ?? []
    }
}

extension DeeplinkItem: RawRepresentable {
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "|")
        
        guard components.count == 4, let host = DeeplinkHost(rawValue: components[1]) else { return nil }
        title = components[0]
        deeplink = Deeplink(host: host, path: DeeplinkPath(rawValue: components[2]))
        version = components[3]
    }
    
    var rawValue: String {
        "\(title)|\(deeplink.host.rawValue)|\(deeplink.path?.type ?? "")|\(version)"
    }
}

extension DeeplinkItem: Identifiable {
    
    var id: String {
        deeplink.id
    }
}

extension DeeplinkItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension DeeplinkItem: Equatable {
    
    static func ==(lhs: DeeplinkItem, rhs: DeeplinkItem) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension DeeplinkItem {
    
    static var placeholder: DeeplinkItem {
        DeeplinkItem(title: "알뜰쇼핑", deeplink: .placeholder, version: "1.0.0")
    }
}
#endif
