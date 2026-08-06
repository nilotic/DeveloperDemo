//
//  DeleteAccountRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct DeleteAccountRequest {
    let reason: String
}

extension DeleteAccountRequest: Encodable {
    
    private enum Key: String, CodingKey {
        case reason
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(reason, forKey: .reason) } catch { throw error }
    }
}
