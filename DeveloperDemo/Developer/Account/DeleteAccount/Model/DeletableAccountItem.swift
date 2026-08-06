//
//  DeletableAccountItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct DeletableAccountItem: Identifiable {
    let id: String
    let name: String
    let email: String
    let userNumber: Int
}

extension DeletableAccountItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension DeletableAccountItem: Equatable {
    
    static func ==(lhs: DeletableAccountItem, rhs: DeletableAccountItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension DeletableAccountItem: Decodable {

    private enum Key: String, CodingKey {
        case id = "memberId"
        case name
        case email
        case userNumber = "memberNo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { id = try container.decode(String.self, forKey: .id) } catch { throw error }
        do { name = try container.decode(String.self, forKey: .name) } catch { throw error }
        do { email = try container.decode(String.self, forKey: .email) } catch { throw error }
        do { userNumber = try container.decode(Int.self, forKey: .userNumber) } catch { throw error }
    }
}

#if DEBUG
extension DeletableAccountItem {
    
    static var placeholder: DeletableAccountItem {
        DeletableAccountItem(id: "sample123", name: "홍길동", email: "sample@example.com", userNumber: 235234)
    }
}
#endif
