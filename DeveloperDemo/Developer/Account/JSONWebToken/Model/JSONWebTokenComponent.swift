//
//  JSONWebTokenComponent.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

enum JSONWebTokenComponent {
    case header(JSONWebTokenHeader)
    case payload(JSONWebTokenPayload)
    case signature(String)
}

extension JSONWebTokenComponent {
    
    var title: String {
        switch self {
        case .header:       "Header"
        case .payload:      "Payload"
        case .signature:    "Signature"
        }
    }
    
    var subtitle: String {
        switch self {
        case .header:       String(localized: "algorithmTokenType")
        case .payload:      String(localized: "data")
        case .signature:    ""
        }
    }
    
    var color: Color {
        switch self {
        case .header:       Color(.displayP3, red: 225 / 255, green: 68 / 255, blue: 117 / 255)
        case .payload:      Color(.displayP3, red: 197 / 255, green: 71 / 255, blue: 247 / 255)
        case .signature:    Color(.displayP3, red: 100 / 255, green: 182 / 255, blue: 235 / 255)
        }
    }
}

extension JSONWebTokenComponent: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension JSONWebTokenComponent: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension JSONWebTokenComponent: Equatable {
    
    static func == (lhs: JSONWebTokenComponent, rhs: JSONWebTokenComponent) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension JSONWebTokenComponent: RawRepresentable {
    
    init?(rawValue: String) {
        if rawValue.hasPrefix("HEADER") {
            guard let header = JSONWebTokenHeader(rawValue: rawValue.replacingOccurrences(of: "HEADER", with: "")) else { return nil }
            self = .header(header)
            
        } else if rawValue.hasPrefix("PAYLOAD") {
            guard let payload = JSONWebTokenPayload(rawValue: rawValue.replacingOccurrences(of: "PAYLOAD", with: "")) else { return nil }
            self = .payload(payload)
            
        } else if rawValue.hasPrefix("SIGNATURE") {
            self = .signature(rawValue.replacingOccurrences(of: "SIGNATURE", with: ""))
        
        } else {
            return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .header(let header):           return "HEADER\(header.rawValue)"
        case .payload(let payload):         return "PAYLOAD\(payload.rawValue)"
        case .signature(let signature):     return "SIGNATURE\(signature)"
        }
    }
}

extension JSONWebTokenComponent: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .header(let header):           return header.description
        case .payload(let payload):         return payload.description
        case .signature(let signature):     return signature
        }
    }
}

extension JSONWebTokenComponent {
    
    static var placeholder: JSONWebTokenComponent {
        JSONWebTokenComponent.header(JSONWebTokenHeader(keyID: "132123", algorithm: "HS256", type: "JWT"))
    }
}
