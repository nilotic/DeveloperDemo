//
//  HapticItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

enum HapticItem: String, CaseIterable {
    case selection
    case intensity
    case light
    case medium
    case heavy
    case soft
    case rigid
    case success
    case warning
    case error
}

extension HapticItem {
    
    var title: LocalizedStringKey {
        switch self {
        case .selection:    "selection"
        case .intensity:    "intensity"
        case .light:        "light"
        case .medium:       "medium"
        case .heavy:        "heavy"
        case .soft:         "soft"
        case .rigid:        "rigid"
        case .success:      "success"
        case .warning:      "warning"
        case .error:        "error"
        }
    }
    
    var titleColor: Color {
        Color(.displayP3, red: 36 / 255, green: 36 / 255, blue: 36 / 255)
    }
}

extension HapticItem: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension HapticItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension HapticItem: Equatable {
    
    static func == (lhs: HapticItem, rhs: HapticItem) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension HapticItem {
    
    static var placeholder: HapticItem {
        .selection
    }
}
#endif
