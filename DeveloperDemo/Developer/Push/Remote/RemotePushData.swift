//
//  RemotePushData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine
import UserNotifications
import OSLog

@MainActor
@Observable
final class RemotePushData {
    
    // MARK: - Value
    // MARK: Public
    var title = ""
    var subtitle = ""
    var body = ""
    
    var thread: PushThread = .delivery
    var badge: UInt = 0
    var category: RemotePushCategory = .market
    var apnsPriority: UInt = 5
    var sound: UNNotificationSound = .default
    var interruptionLevel: UNNotificationInterruptionLevel = .active
    var imageURL = ""
    
    var link = ""
    var toastMessage = ""
    
    var items = [RemotePushInformationItem]()
    
    private(set) var firebaseToken: FirebaseToken?
    private(set) var deviceToken = ""
    private(set) var firebaseCloudMessagingToken = ""
    private(set) var isAnimating = false
    private(set) var isProgressing = false
        
    var isGooglePlaygroundOAuthViewPresented = false
    var isInformationViewPresented = false
    
    let interruptionLevels: [(String, UNNotificationInterruptionLevel)] = [(String(localized: "passive"), .passive), (String(localized: "active"), .active), 
                                                                           (String(localized: "timeSensitive"), .timeSensitive), (String(localized: "critical"), .critical)]
    
    var sounds: [(String, UNNotificationSound)] = [(String(localized: "default"), .default), (String(localized: "critical"), .defaultCritical)]
    
    // MARK: Private
    private let tokenKey = "GoogleOAuthFirebaseCloudMessagingPlaygroundToken"
    @ObservationIgnored
    private var task: Task<Void, Never>? = nil
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        Task {
            isProgressing = true

            await updateToken()
            let deviceToken = UserDefaults.standard.pushDeviceToken?.map { String(format: "%02.2hhx", $0) }.joined() ?? ""
            
            title = String(localized: "service")
            subtitle = String(localized: "deliveryInformation")
            body = String(localized: "deliveryComplete")
            link = "service://cart"
            imageURL = "https://www.example.com/sample.jpg"
            
            self.deviceToken = deviceToken
            firebaseCloudMessagingToken = UserDefaults.standard.firebaseToken ?? ""
            
            items = [RemotePushInformationItem(title: "deviceToken", token: deviceToken),
                     RemotePushInformationItem(title: "firebaseCloudMessagingToken", token: firebaseCloudMessagingToken, isEditable: true)]
            
            if #available(iOS 15.2, *) {
                sounds.append((String(localized: "ringtone"), .defaultRingtone))
            }
            
            isProgressing = false
        }
    }
    
    func send() {
        task?.cancel()
        task = Task {
            guard firebaseToken != nil else {
                isGooglePlaygroundOAuthViewPresented = true
                return
            }
            
            isProgressing = true
            
            do {
                let response = try await requestSend()
                
                toastMessage = """
                               \(title)
                               \(subtitle)
                               \(body)
                               
                               
                               🧵 Thread: \(thread.rawValue)
                               📋 Category: \(category.rawValue)
                               📌 Badge: \(badge)
                               🔉 Sound: \(sounds.first(where: { $0.1 == sound })?.0 ?? "")
                               📣 Interruption Level:  \(interruptionLevel.rawValue)
                               ⏱️ APNS Priority: \(apnsPriority)
                               
                               
                               🔖 Response
                               \(response.name)
                               """
                
            } catch {
                #if DEBUG
                Logger(subsystem: "Developer", category: "RemotePush").error("\(error.localizedDescription)")
                #endif
                
                toastMessage = error.localizedDescription
                
                if (error as? ServiceError)?.code == "401" {
                    firebaseToken = nil
                    UserDefaults.standard.removeObject(forKey: tokenKey)
                }
            }
            
            isProgressing = false
            task = nil
        }
    }
    
    func handle(token: FirebaseToken) {
        self.firebaseToken = token
        
        // Save token
        guard let encodedData = try? JSONEncoder().encode(token) else { return }
        UserDefaults.standard.set(encodedData, forKey: tokenKey)
        
        // Send
        send()
    }
    
    func update(token: String) {
        guard let index = items.firstIndex(where: { $0.isEditable }) else { return }
        firebaseCloudMessagingToken = token
        items[index].token = token
    }
    
    // MARK: Private
    private func requestSend() async throws -> FirebaseCloudMessagingResponse {
        guard let accessToken = firebaseToken?.accessToken else { throw URLError(.badServerResponse) }
        
        var request = await URLRequest(httpMethod: .post, url: .sendMessage)
        request.set(value: .application(.json), field: .contentType)
        request.set(value: .authorization(HTTPAuthorization(scheme: .bearer, parameter: accessToken)), field: .authorization)
        
        // Apple Push Notification Service
        let alert = ApplePushServiceAlert(title: title, subtitle: subtitle, body: body)
        let service = ApplePushService(alert: alert, badge: badge, sound: sound, category: category, thread: thread, interruptionLevel: interruptionLevel)
        
        let headers = ApplePushNotificationServiceHeaders(apnsPriority: apnsPriority)
        let payload = ApplePushNotificationServicePayload(service: service, imageURL: URL(string: imageURL), url: URL(string: link))
        
        let configuration = ApplePushNotificationServiceConfiguration(headers: headers, payload: payload)
    
        // Firebase Cloud Message
        let message = FirebaseCloudMessage(configuration: configuration, token: firebaseCloudMessagingToken)
        let requestData = FirebaseCloudMessagingRequest(message: message)
        
        // Request
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)

        guard let data = response.data else { throw response.error ?? URLError(.badServerResponse) }
        return try JSONDecoder().decode(FirebaseCloudMessagingResponse.self, from: data)
    }
    
    private func updateToken() async {
        guard let data = UserDefaults.standard.data(forKey: tokenKey), let firebaseToken = try? JSONDecoder().decode(FirebaseToken.self, from: data) else { return }
                
        if firebaseToken.isExpired {
            UserDefaults.standard.removeObject(forKey: tokenKey)
            
        } else {
            self.firebaseToken = firebaseToken
        }
    }
}
