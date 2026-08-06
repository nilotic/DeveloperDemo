//
//  FirebaseCloudMessage.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseCloudMessage {
    var data: FirebaseCloudMessageData?
    let configuration: ApplePushNotificationServiceConfiguration
    let token: String
}

extension FirebaseCloudMessage: Encodable {
    
    private enum Key: String, CodingKey {
        case data
        case configuration = "apns"
        case token
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(configuration, forKey: .configuration) } catch { throw error }
        
        if let data {
            do { try container.encode(data, forKey: .data) } catch { throw error }
        }
        
        if !token.isEmpty {
            do { try container.encode(token, forKey: .token) } catch { throw error }
        }
    }
}

#if DEBUG
extension FirebaseCloudMessage {
 
    static var placeholder: FirebaseCloudMessage {
        FirebaseCloudMessage(data: .placeholder, configuration: .placeholder, token: "")
    }
}
#endif
