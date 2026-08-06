//
//  AccountLockStatus.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum AccountLockStatus: String {
    case locked = "LOCKED"
    case unlocked = "NORMAL"
}

extension AccountLockStatus: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension AccountLockStatus: Equatable {
    
    static func == (lhs: AccountLockStatus, rhs: AccountLockStatus) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension AccountLockStatus: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        do { try container.encode(rawValue) } catch { throw error }
    }
}

extension AccountLockStatus: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            guard let status = AccountLockStatus(rawValue: try container.decode(RawValue.self)) else {
                throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to decode a Account Lock Status."))
            }
            
            self = status
            
        } catch { throw error }
    }
}
