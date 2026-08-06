//
//  FirebaseCloudMessagingResponse.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseCloudMessagingResponse {
    let name: String
}

extension FirebaseCloudMessagingResponse: Decodable {

    private enum Key: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { name = try container.decode(String.self, forKey: .name) } catch { throw error }
    }
}
