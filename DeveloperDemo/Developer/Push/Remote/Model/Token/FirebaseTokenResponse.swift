//
//  FirebaseTokenResponse.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseTokenResponse {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

extension FirebaseTokenResponse: Decodable {

    private enum Key: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { accessToken = try container.decode(String.self, forKey: .accessToken) } catch { throw error }
        do { refreshToken = try container.decode(String.self, forKey: .refreshToken) } catch { throw error }
        do { expiresIn = try container.decode(Int.self, forKey: .expiresIn) } catch { throw error }
    }
}
