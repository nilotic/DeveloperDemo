//
//  AccountOperationInformation.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct AccountOperationInformation {
    let isSpecialCare: Bool
    let isSpecialPacking: Bool
}

extension AccountOperationInformation: Identifiable {
    
    var id: String {
        "\(isSpecialCare)\(isSpecialPacking)"
    }
}

extension AccountOperationInformation: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension AccountOperationInformation: Equatable {
    
    static func == (lhs: AccountOperationInformation, rhs: AccountOperationInformation) -> Bool {
        lhs.id == rhs.id
    }
}

extension AccountOperationInformation: Decodable {

    private enum Key: String, CodingKey {
        case isSpecialCare
        case isSpecialPacking
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
     
        do { isSpecialCare = try container.decode(Bool.self, forKey: .isSpecialCare) } catch { throw error }
        do { isSpecialPacking = try container.decode(Bool.self, forKey: .isSpecialPacking) } catch { throw error }
    }
}

#if DEBUG
extension AccountOperationInformation {
    
    static var placeholder: AccountOperationInformation {
        AccountOperationInformation(isSpecialCare: true, isSpecialPacking: true)
    }
}
#endif
