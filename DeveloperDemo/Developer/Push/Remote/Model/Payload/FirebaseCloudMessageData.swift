//
//  FirebaseCloudMessageData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseCloudMessageData {
    let id: String
    let imageURL: URL?
}

extension FirebaseCloudMessageData: Encodable {
    
    private enum Key: String, CodingKey {
        case id = "messageId"
        case imageURL = "image"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(id, forKey: .id) } catch { throw error }
        do { try container.encode(imageURL, forKey: .imageURL) } catch { throw error }
    }
}

#if DEBUG
extension FirebaseCloudMessageData {
    
    static var placeholder: FirebaseCloudMessageData {
        FirebaseCloudMessageData(id: "123123", imageURL: URL(string: "https://product-image.example.com/product/image/d9cbe164-7e1c-4b58-aa30-e603b35ddb60.jpg"))
    }
}
#endif

