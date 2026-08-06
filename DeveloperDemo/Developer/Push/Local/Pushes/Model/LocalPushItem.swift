//
//  LocalPushItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import UserNotifications

struct LocalPushItem: Identifiable {
    let id: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    let body: LocalizedStringKey
    let thread: PushThread
    let badge: UInt
    let url: URL?
    let date: Date
}

extension LocalPushItem: RawRepresentable {
    
    init(request: UNNotificationRequest) {
        id = request.identifier
        title = LocalizedStringKey(request.content.title)
        subtitle = LocalizedStringKey(request.content.subtitle)
        body = LocalizedStringKey(request.content.body)
        thread = PushThread(rawValue: request.content.threadIdentifier) ?? .announcement
        badge = request.content.badge?.uintValue ?? 0
        url = request.content.attachments.first?.url
        date = (request.trigger as? UNTimeIntervalNotificationTrigger)?.nextTriggerDate() ?? Date()
    }
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "|")
        
        guard components.count == 8 else { return nil }
        id = components[0]
        title = LocalizedStringKey(components[1])
        subtitle = LocalizedStringKey(components[2])
        body = LocalizedStringKey(components[3])
        thread = PushThread(rawValue: components[4]) ?? .announcement
        badge = UInt(components[5]) ?? 0
        url = URL(string: components[6])
        date = Date(timeIntervalSince1970: TimeInterval(components[7]) ?? 0)
    }

    var rawValue: String {
        "\(id)|\(title)|\(subtitle)|\(body)|\(thread.rawValue)|\(badge)|\(url?.absoluteString ?? "")|\(date.timeIntervalSince1970)"
    }
}

extension LocalPushItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension LocalPushItem: Equatable {
    
    static func == (lhs: LocalPushItem, rhs: LocalPushItem) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension LocalPushItem {
    
    static var placeholder: LocalPushItem {
        LocalPushItem(id: UUID().uuidString, title: "service", subtitle: "deliveryInformation", body: "deliveryComplete", thread: .delivery, badge: 1, url: URL(string: "service://cart"), date: Date())
    }
}
#endif
