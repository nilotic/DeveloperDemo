//
//  Response.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct Response<T: Decodable> {
    let data: T
}

extension Response: Decodable {

    private enum Key: String, CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { data = try container.decode(T.self, forKey: .data) } catch { throw error }
    }
}
