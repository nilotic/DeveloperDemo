//
//  EditAccountRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct EditAccountRequest {
    let status: AccountLockStatus
}

extension EditAccountRequest: Encodable {

    private enum Key: String, CodingKey {
        case status = "loginStatus"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(status, forKey: .status) } catch { throw error }
    }
}
