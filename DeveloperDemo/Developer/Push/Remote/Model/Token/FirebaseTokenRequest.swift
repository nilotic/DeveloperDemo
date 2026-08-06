//
//  FirebaseTokenRequest.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseTokenRequest {
    let code: String
    let tokenURI: URL
}

extension FirebaseTokenRequest: Encodable {
    
    private enum Key: String, CodingKey {
        case code
        case tokenURI = "token_uri"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(code, forKey: .code) } catch { throw error }
        do { try container.encode(tokenURI, forKey: .tokenURI) } catch { throw error }
    }
}
