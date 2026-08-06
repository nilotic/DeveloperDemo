//
//  OperationManagement.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct OperationManagement {
    let isSpecialCare: Bool
    let isSpecialPacking: Bool
}

extension OperationManagement: Decodable {

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
