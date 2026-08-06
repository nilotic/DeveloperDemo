//
//  LocalPushesData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import UserNotifications

@MainActor
@Observable
final class LocalPushesData {

    // MARK: - Value
    // MARK: Public
    var sections = [LocalPushSection]()
    
    private(set) var isAlertAuthorized = false
    private(set) var isProgressing = false
    
    var isRegisterViewPresented = false
    var toastMessage = ""
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        Task {
            isProgressing = true
            
            do {
                let isAlertAuthorized = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                let items = await requestItems()
                
                var announcementItems = [LocalPushItem]()
                var deliveryItems = [LocalPushItem]()
                var eventsItems = [LocalPushItem]()
                
                for item in items {
                    setTimers(item: item)
                
                    switch item.thread {
                    case .announcement:     announcementItems.append(item)
                    case .delivery:         deliveryItems.append(item)
                    case .event:            eventsItems.append(item)
                    }
                }
                
                var sections = [LocalPushSection]()
                if !announcementItems.isEmpty {
                    sections.append(LocalPushSection(thread: .announcement, items: announcementItems))
                }
                
                if !deliveryItems.isEmpty {
                    sections.append(LocalPushSection(thread: .delivery, items: deliveryItems))
                }
                
                if !eventsItems.isEmpty {
                    sections.append(LocalPushSection(thread: .event, items: eventsItems))
                }
                
                let updatedSections = sections
                
                await MainActor.run {
                    self.sections = updatedSections
                    self.isAlertAuthorized = isAlertAuthorized
                }
                
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
        }
    }
    
    func unregister(item: LocalPushItem) {
        Task {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
            remove(item: item)
        }
    }
    
    func remove(item: LocalPushItem) {
        Task {
            var sections = sections
           
            for (i, section) in sections.enumerated() {
                guard section.thread == item.thread, let index = section.items.firstIndex(where: { $0 == item }) else { continue }
                sections[i].items.remove(at: index)
                break
            }
            
            withAnimation(.easeInOut(duration: 0.5)) {
                self.sections = sections.filter { !$0.items.isEmpty }
            }
        }
    }
    
    // MARK: Private
    private func setTimers(item: LocalPushItem) {
        Task {
            try await Task.sleep(nanoseconds: UInt64(max(0, item.date.timeIntervalSince1970 - Date().timeIntervalSince1970)) * 1_000_000_000)
            remove(item: item)
        }
    }
    
    private func requestItems() async -> [LocalPushItem] {
        let requests = await UNUserNotificationCenter.current().pendingNotificationRequests()
        return requests.compactMap { LocalPushItem(request: $0) }
    }
}
