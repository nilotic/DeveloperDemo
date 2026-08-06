//
//  SignatureStatus.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

enum SignatureStatus: String {
    case none = "None"
    case invalid = "Invalid"
    case valid  = "Valid"
}

extension SignatureStatus {
    
    var symbolColor: Color {
        switch self {
        case .none:     .gray
        case .invalid:  .red
        case .valid:    .green
        }
    }
}

extension SignatureStatus: CustomStringConvertible {
    
    var description: String {
        rawValue
    }
}

extension SignatureStatus: CustomDebugStringConvertible {
    
    var debugDescription: String {
        description
    }
}

extension SignatureStatus: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension SignatureStatus: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension SignatureStatus: Equatable {
    
    static func ==(lhs: SignatureStatus, rhs: SignatureStatus) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
