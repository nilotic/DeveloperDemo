//
//  WithdrawalAccountItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct WithdrawalAccountItem: Identifiable {
    let id: String
    let date: Date
    let userNumber: Int
}

extension WithdrawalAccountItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension WithdrawalAccountItem: Equatable {
    
    static func ==(lhs: WithdrawalAccountItem, rhs: WithdrawalAccountItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension WithdrawalAccountItem: Decodable {

    private enum Key: String, CodingKey {
        case id = "memberId"
        case date = "withdrawnAt"
        case userNumber = "memberNo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { id = try container.decode(String.self, forKey: .id) } catch { throw error }
        do { userNumber = try container.decode(Int.self, forKey: .userNumber) } catch { throw error }
        
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFormatter.locale = Locale(identifier: "ko")
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
            
            guard let date = dateFormatter.date(from: try container.decode(String.self, forKey: .date)) else {
                throw DecodingError.keyNotFound(Key.date, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to get date."))
            }
            
            self.date = date
            
        } catch { throw error }
    }
}

#if DEBUG
extension WithdrawalAccountItem {
    
    static var placeholder: WithdrawalAccountItem {
        WithdrawalAccountItem(id: "sample123", date: Date(), userNumber: 235234)
    }
}
#endif
