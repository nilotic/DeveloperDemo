//
//  LocalPushSection.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct LocalPushSection {
    let thread: PushThread
    var items: [LocalPushItem]
    var isExpanded = true
}

extension LocalPushSection {
    
    var title: LocalizedStringKey {
        LocalizedStringKey(thread.description)
    }
    
    var imageName: String {
        guard let category = items.first?.thread else { return "" }
        switch category {
        case .announcement:     return "megaphone"
        case .delivery:         return "box.truck"
        case .event:            return "gift"
        }
    }
}

extension LocalPushSection: Identifiable {
    
    var id: String {
        "\(thread.rawValue)\(items.map(\.id).joined())\(isExpanded)"
    }
}

extension LocalPushSection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension LocalPushSection: Equatable {
    
    static func == (lhs: LocalPushSection, rhs: LocalPushSection) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension LocalPushSection {
    
    static var placeholder: LocalPushSection {
        let items = [LocalPushItem(id: "1", title: "service", subtitle: "deliveryInformation", body: "deliveryComplete", thread: .delivery, badge: 1, url: URL(string: "service://cart"), date: Date()),
                     LocalPushItem(id: "2", title: "service", subtitle: "deliveryInformation", body: "deliveryComplete", thread: .delivery, badge: 1, url: URL(string: "service://cart"), date: Date()),
                     LocalPushItem(id: "3", title: "service", subtitle: "deliveryInformation", body: "deliveryComplete", thread: .delivery, badge: 1, url: URL(string: "service://cart"), date: Date())]
        
        return LocalPushSection(thread: .announcement, items: items)
    }
}
#endif
