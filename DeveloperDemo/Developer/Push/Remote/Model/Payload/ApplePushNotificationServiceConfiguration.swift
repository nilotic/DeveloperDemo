//
//  ApplePushNotificationServiceConfiguration.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ApplePushNotificationServiceConfiguration {
    let headers: ApplePushNotificationServiceHeaders
    let payload: ApplePushNotificationServicePayload
}

extension ApplePushNotificationServiceConfiguration: Encodable {
    
    private enum Key: String, CodingKey {
        case headers
        case payload
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(headers, forKey: .headers) } catch { throw error }
        do { try container.encode(payload, forKey: .payload) } catch { throw error }
    }
}

#if DEBUG
extension ApplePushNotificationServiceConfiguration {
    
    static var placeholder: ApplePushNotificationServiceConfiguration {
        ApplePushNotificationServiceConfiguration(headers: .placeholder, payload: .placeholder)
    }
}
#endif

