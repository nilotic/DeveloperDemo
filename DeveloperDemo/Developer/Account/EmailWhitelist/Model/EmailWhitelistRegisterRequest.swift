//
//  EmailWhitelistRegisterRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct EmailWhitelistRegisterRequest {
    let email: String
    let phoneNumber: String
    let teamName: String
}

extension EmailWhitelistRegisterRequest: Encodable {

    private enum Key: String, CodingKey {
        case email
        case phoneNumber = "mobile"
        case teamName = "name"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)

        do { try container.encode(email, forKey: .email) } catch { throw error }
        do { try container.encode(phoneNumber, forKey: .phoneNumber) } catch { throw error }
        do { try container.encode(teamName, forKey: .teamName) } catch { throw error }
    }
}
