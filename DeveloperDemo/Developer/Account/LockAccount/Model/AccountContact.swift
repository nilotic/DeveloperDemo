//
//  AccountContact.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct AccountContact {
    let email: String
    let phoneNumber: String
    let isSNSAgreed: Bool
}

extension AccountContact: Decodable {

    private enum Key: String, CodingKey {
        case email
        case phoneNumber = "mobile"
        case isSNSAgreed = "smsYn"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { email = try container.decode(String.self, forKey: .email) } catch { throw error }
        do { phoneNumber = try container.decode(String.self, forKey: .phoneNumber) } catch { throw error }
        do { isSNSAgreed = (try container.decode(String.self, forKey: .isSNSAgreed)) == "y" ? true : false } catch { throw error }
    }
}
