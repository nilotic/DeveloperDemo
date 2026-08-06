//
//  ColorPaletteType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ColorPaletteType: String {
    case service
    case designSystem
}

extension ColorPaletteType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .service:           String(localized: "service")
        case .designSystem:    String(localized: "designSystem")
        }
    }
}

extension ColorPaletteType: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension ColorPaletteType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension ColorPaletteType: Equatable {
    
    static func ==(lhs: ColorPaletteType, rhs: ColorPaletteType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension ColorPaletteType: CaseIterable {
    
    static var allCases: [ColorPaletteType] {
        [.service, .designSystem]
    }
}
