//
//  DeletableAccountSearchResponse.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct DeletableAccountSearchResponse {
    let items: [DeletableAccountItem]
}

extension DeletableAccountSearchResponse: Decodable {

    private enum Key: String, CodingKey {
        case items = "content"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { items = try container.decode([DeletableAccountItem].self, forKey: .items) } catch { items = [] }
    }
}
