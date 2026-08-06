//
//  ApplePushNotificationServiceHeaders.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

/**
 To deliver the notifications, you’re required to have some header fields. In addition to the preceding data, add the following header fields in to your request.
 Other headers are optional or may depend on whether you’re using token-based or certificate-based authentication.
 */

struct ApplePushNotificationServiceHeaders {
    /**
    The priority of the notification. If you omit this header, APNs sets the notification priority to 10.
    Specify 10 to send the notification immediately.
    Specify 5 to send the notification based on power considerations on the user’s device.
    Specify 1 to prioritize the device’s power considerations over all other factors for delivery, and prevent awakening the device.
    */
    let apnsPriority: UInt
}

extension ApplePushNotificationServiceHeaders: Encodable {
    
    private enum Key: String, CodingKey {
        case apnsPriority = "apns-priority"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode("\(apnsPriority)", forKey: .apnsPriority) } catch { throw error }
    }
}

#if DEBUG
extension ApplePushNotificationServiceHeaders {
    
    static var placeholder: ApplePushNotificationServiceHeaders {
        ApplePushNotificationServiceHeaders(apnsPriority: 5)
    }
}
#endif
