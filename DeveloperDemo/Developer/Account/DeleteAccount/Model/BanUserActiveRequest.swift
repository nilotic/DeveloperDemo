//
//  BanUserActiveRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct BanUserActiveRequest {
    let userNumber: Int
}

extension BanUserActiveRequest: Encodable {

    private enum Key: String, CodingKey {
        case userNumber = "memberNo"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(userNumber, forKey: .userNumber) } catch { throw error }
    }
}
