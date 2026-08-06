//
//  ColorExtension.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let characters = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        guard let int = Scanner(string: characters).scanInt(representation: .hexadecimal) else {
            self = .clear
            return
        }
        
        let alpha, red, green, blue: Int
        switch characters.count {
        case 3:     (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
        case 6:     (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
        case 8:     (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
        default:    (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        
        self = Color(.displayP3, red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255).opacity(Double(alpha) / 255)
    }
}

extension Color {
    
    var components: (red: Int, green: Int, blue: Int, alpha: Int) {
        let color = CIColor(color: UIColor(self))
        return (lroundf(Float(color.red * 255)), lroundf(Float(color.green * 255)), lroundf(Float(color.blue * 255)), lroundf(Float(color.alpha * 255)))
    }
    
    var rgba: String {
        let components = components
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        let alpha = numberFormatter.string(for: Float(components.alpha) / 255) ?? "0"
        return "(\(components.red), \(components.green), \(components.blue), \(alpha))"
    }
    
    var hex: String {
        let components = components
        return String(format: "#%02lX%02lX%02lX%02lX", components.alpha, components.red, components.green, components.blue)
    }
}
