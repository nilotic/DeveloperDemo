//
//  EditableAccountItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct EditableAccountItem: Identifiable {
    let id: String
    let name: String
    let email: String
    let userNumber: Int
    let level: UInt
    let blackMemberCode: String
    var status: AccountLockStatus
}

extension EditableAccountItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension EditableAccountItem: Equatable {
    
    static func == (lhs: EditableAccountItem, rhs: EditableAccountItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension EditableAccountItem: Decodable {

    private enum Key: String, CodingKey {
        case id = "memberId"
        case name
        case email
        case userNumber = "memberNo"
        case level
        case blackMemberCode
        case status = "loginStatus"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { id = try container.decode(String.self, forKey: .id) } catch { throw error }
        do { name = try container.decode(String.self, forKey: .name) } catch { throw error }
        do { email = try container.decode(String.self, forKey: .email) } catch { throw error }
        do { userNumber = try container.decode(Int.self, forKey: .userNumber) } catch { throw error }
        do { level = try container.decode(UInt.self, forKey: .level) } catch { throw error }
        do { blackMemberCode = try container.decode(String.self, forKey: .blackMemberCode) } catch { throw error }
        do { status = try container.decode(AccountLockStatus.self, forKey: .status) } catch { throw error }
    }
}

#if DEBUG
extension EditableAccountItem {
    
    static var placeholder: EditableAccountItem {
        EditableAccountItem(id: "sample123", name: "홍길동", email: "sample@example.com", userNumber: 235234, level: 17, blackMemberCode: "N", status: .locked)
    }
}
#endif
