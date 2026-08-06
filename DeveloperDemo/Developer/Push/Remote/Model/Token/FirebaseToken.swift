//
//  FirebaseToken.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct FirebaseToken {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let date: Date
}

extension FirebaseToken {
 
    var isExpired: Bool {
        guard let expirationDate = Calendar.current.date(byAdding: DateComponents(second: expiresIn), to: date) else { return true }
        return expirationDate < Date()
    }
}

extension FirebaseToken {
    
    init(data: FirebaseTokenResponse) {
        accessToken = data.accessToken
        refreshToken = data.refreshToken
        expiresIn = data.expiresIn
        date = Date()
    }
}

extension FirebaseToken: Codable {
    
    private enum Key: String, CodingKey {
        case accessToken
        case refreshToken
        case expiresIn
        case date
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(accessToken, forKey: .accessToken) } catch { throw error }
        do { try container.encode(refreshToken, forKey: .refreshToken) } catch { throw error }
        do { try container.encode(expiresIn, forKey: .expiresIn) } catch { throw error }
        do { try container.encode(date, forKey: .date) } catch { throw error }
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { accessToken = try container.decode(String.self, forKey: .accessToken) } catch { throw error }
        do { refreshToken = try container.decode(String.self, forKey: .refreshToken) } catch { throw error }
        do { expiresIn = try container.decode(Int.self, forKey: .expiresIn) } catch { throw error }
        do { date = try container.decode(Date.self, forKey: .date) } catch { throw error }
    }
}
