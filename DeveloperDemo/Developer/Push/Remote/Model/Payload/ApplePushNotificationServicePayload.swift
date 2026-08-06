//
//  ApplePushNotificationServicePayload.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ApplePushNotificationServicePayload {
    let service: ApplePushService
    var imageURL: URL?
    var url: URL?
}

extension ApplePushNotificationServicePayload: Encodable {
    
    private enum Key: String, CodingKey {
        case service = "aps"
        case imageURL = "image"
        case url
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(service, forKey: .service) } catch { throw error }
        
        if let imageURL {
            do { try container.encode(imageURL, forKey: .imageURL) } catch { throw error }
        }
        
        if let url {
            do { try container.encode(url, forKey: .url) } catch { throw error }
        }
    }
}

#if DEBUG
extension ApplePushNotificationServicePayload {
    
    static var placeholder: ApplePushNotificationServicePayload {
        ApplePushNotificationServicePayload(service: .placeholder)
    }
}
#endif

