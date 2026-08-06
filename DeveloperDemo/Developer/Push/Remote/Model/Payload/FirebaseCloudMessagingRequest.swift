//
//  FirebaseCloudMessagingRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseCloudMessagingRequest {
    let message: FirebaseCloudMessage
}

extension FirebaseCloudMessagingRequest: Encodable {

    private enum Key: String, CodingKey {
        case validateOnly = "validate_only"
        case message
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(false, forKey: .validateOnly) } catch { throw error }
        do { try container.encode(message, forKey: .message) } catch { throw error }
    }
}
