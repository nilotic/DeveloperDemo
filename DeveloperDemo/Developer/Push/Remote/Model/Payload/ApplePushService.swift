//
//  ApplePushService.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UserNotifications

struct ApplePushService {
    /// The information for displaying an alert. A dictionary is recommended. If you specify a string, the alert displays your string as the body text. 
    var alert: ApplePushServiceAlert?
    
    /// The number to display in a badge on your app’s icon. Specify 0 to remove the current badge, if any.
    var badge: UInt = 0
    
    /// The name of a sound file in your app’s main bundle or in the Library/Sounds folder of your app’s container directory. Specify the string “default” to play the system sound. Use this key for regular notifications. For critical alerts, use the sound dictionary instead.
    var sound: UNNotificationSound?
    
    /// The notification’s type. This string must correspond to the identifier of one of the UNNotificationCategory objects you register at launch time.
    var category: RemotePushCategory?
    
    /// An app-specific identifier for grouping related notifications. This value corresponds to the threadIdentifier property in the UNNotificationContent object.
    var thread: PushThread?
    
    /// The importance and delivery timing of a notification. The string values “passive”, “active”, “time-sensitive”, or “critical” correspond to the UNNotificationInterruptionLevel enumeration cases.
    var interruptionLevel: UNNotificationInterruptionLevel?
    
    /// The notification service app extension flag. If the value is 1, the system passes the notification to your notification service app extension before delivery. Use your extension to modify the notification’s content.
    var mutableContent = 1
}

extension ApplePushService {

    var soundRawValue: String {
        guard let sound else { return "" }
        switch sound {
        case .default:          return "default"
        case .defaultCritical:  return "critical"
            
        default:
            if #available(iOS 15.2, *), sound == .defaultRingtone {
                return "ringtone"
        
            } else {
                return ""
            }
        }
    }
    
    var interruptionLevelRawValue: String {
        guard let interruptionLevel else { return "" }
        switch interruptionLevel {
        case .active:           return "active"
        case .critical:         return "critical"
        case .passive:          return "passive"
        case .timeSensitive:    return "time-sensitive"
        default:                return ""
        }
    }
}

extension ApplePushService: Encodable {
    
    private enum Key: String, CodingKey {
        case alert
        case badge
        case sound
        case category
        case threadID
        case interruptionLevel = "interruption-level"
        case mutableContent = "mutable-content"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        if let alert {
            do { try container.encode(alert, forKey: .alert) } catch { throw error }
        }
        
        do { try container.encode(badge, forKey: .badge) } catch { throw error }
        
        if !soundRawValue.isEmpty {
            do { try container.encode(soundRawValue, forKey: .sound) } catch { throw error }
        }

        if let category {
            do { try container.encode(category, forKey: .category) } catch { throw error }
        }
        
        if let thread {
            do { try container.encode(thread, forKey: .threadID) } catch { throw error }
        }
        
        if !interruptionLevelRawValue.isEmpty {
            do { try container.encode(interruptionLevelRawValue, forKey: .interruptionLevel) } catch { throw error }
        }

        do { try container.encode(mutableContent, forKey: .mutableContent) } catch { throw error }
    }
}

#if DEBUG
extension ApplePushService {
    
    static var placeholder: ApplePushService {
        ApplePushService(alert: .placeholder, badge: 2, sound: .default, category: .market, interruptionLevel: .timeSensitive)
    }
}
#endif
