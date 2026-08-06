//
//  LocalPushRegisterData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import PhotosUI
import Combine
import UserNotifications

@available(iOS 16, *)
@MainActor
@Observable
final class LocalPushRegisterData {
    
    // MARK: - Value
    // MARK: Public
    var title = ""
    var subtitle = ""
    var body = ""
    var thread: PushThread = .delivery
    var badge: UInt = 0
    var sound: UNNotificationSound = .default
    
    var hours: UInt = 0
    var minutes: UInt = 0
    var seconds: UInt = 0
    var interruptionLevel: UNNotificationInterruptionLevel = .timeSensitive
    var deeplink = ""
    
    var photosPickerItem: PhotosPickerItem? = nil {
        didSet { updateImage() }
    }
    
    var isRepeats = false {
        didSet {
            guard isRepeats, timeInterval < 60 else { return }
            minutes = 1
        }
    }
    
    var toastMessage = ""
    
    private(set) var attachment: UNNotificationAttachment?
    private(set) var isRegistered = false
    private(set) var isProgressing = false
    
    let interruptionLevels: [(String, UNNotificationInterruptionLevel)] = [(String(localized: "passive"), .passive), (String(localized: "active"), .active),
                                                                           (String(localized: "timeSensitive"), .timeSensitive), (String(localized: "critical"), .critical)]
    
    let sounds: [(String, UNNotificationSound)] = [(String(localized: "default"), .default), (String(localized: "critical"), .defaultCritical), (String(localized: "ringtone"), .defaultRingtone)]
    
    // MARK: Private
    @ObservationIgnored
    private var task: Task<Void, Never>?
    
    private var timeInterval: TimeInterval {
        TimeInterval(hours * 60 * 60 + minutes * 60 + seconds)
    }
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        title = String(localized: "service")
        subtitle = String(localized: "deliveryInformation")
        body = String(localized: "deliveryComplete")
        deeplink = "service://cart"
        seconds = 5
    }
    
    func register() {
        task?.cancel()
        
        task = Task {
            isProgressing = true
            
            // Content
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            content.body = body
            content.threadIdentifier = thread.rawValue
            content.badge = NSNumber(value: badge)
            content.sound = sound
            content.interruptionLevel = interruptionLevel
            content.userInfo = ["deeplink": deeplink]
            
            if let attachment {
                content.attachments = [attachment]
            }
            
            // Request
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: isRepeats)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
             
            await MainActor.run {
                UNUserNotificationCenter.current().add(request)
            }
            
            isRegistered = true
            
            isProgressing = false
            task = nil
        }
    }
    
    // MARK: Private
    private func updateImage() {
        Task {
            guard let photosPickerItem else { return }
            
            do {
                guard let data = try await photosPickerItem.loadTransferable(type: Data.self) else {
                    toastMessage = String(localized: "invalidPhotosPermission")
                    return
                }
                
                guard let fileExtension = photosPickerItem.supportedContentTypes.first?.preferredFilenameExtension, 
                        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
                
                if !FileManager.default.fileExists(atPath: url.absoluteString) {
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                }
                
                let identifier = UUID().uuidString
                let path = url.appendingPathComponent("\(identifier).\(fileExtension)")
                
                try data.write(to: path)
                
                let attachment = try UNNotificationAttachment(identifier: identifier, url: path, options: [:])
                await MainActor.run { self.attachment = attachment }
                
            } catch {
                await MainActor.run { toastMessage = error.localizedDescription }
            }
        }
    }
}
