//
//  HTTPAuthorization.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct HTTPAuthorization {
    let scheme: AuthorizationScheme
    let parameter: String
}

extension HTTPAuthorization: RawRepresentable {
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: " ")
        guard let scheme = AuthorizationScheme(rawValue: components.first ?? ""), let parameter = components.last else { return nil }
        
        self.scheme = scheme
        self.parameter = parameter
    }
    
    var rawValue: String {
        "\(scheme.rawValue)\(scheme == .service ? "" : " ")\(parameter)"
    }
}

extension HTTPAuthorization: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension HTTPAuthorization: Equatable {
    
    static func == (lhs: HTTPAuthorization, rhs: HTTPAuthorization) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension HTTPAuthorization: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension HTTPAuthorization: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}
