//
//  Typography.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Typography {
    let index: UInt
    var size: CGFloat
    var weight: Font.Weight
    var lineHeight: CGFloat
    let content: String
    var color: Color = .black
}

extension Typography {
    
    var font: Font {
        .system(size: size, weight: weight)
    }
    
    var lineSpacing: CGFloat {
        var uiFontWeight: UIFont.Weight {
            switch weight {
            case .ultraLight:   .ultraLight
            case .thin:         .thin
            case .light:        .light
            case .regular:      .regular
            case .medium:       .medium
            case .semibold:     .semibold
            case .bold:         .bold
            case .heavy:        .heavy
            case .black:        .black
            default:            .regular
            }
        }
        
        return lineHeight - UIFont.systemFont(ofSize: size, weight: uiFontWeight).lineHeight
    }
    
    var weightDescription: String {
        switch weight {
        case .ultraLight:   String(localized: "ultraLight")
        case .thin:         String(localized: "thin")
        case .light:        String(localized: "light")
        case .regular:      String(localized: "regular")
        case .medium:       String(localized: "medium")
        case .semibold:     String(localized: "semibold")
        case .bold:         String(localized: "bold")
        case .heavy:        String(localized: "heavy")
        case .black:        String(localized: "black")
        default:            String(localized: "regular")
        }
    }
}

extension Typography: Identifiable {
    
    var id: String {
        "\(index)"
    }
}

extension Typography: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Typography: Equatable {
    
    static func ==(lhs: Typography, rhs: Typography) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension Typography {
    
    static var placeholder: Typography {
        let content = """
                      ABCDEFGHIJKLMNOPQRSTUVWXYZ
                      가나다라마바사아자차카타파하
                      샛별이 뜰 때가 가장 신선할 때 내일의 장보기 데모마켓
                      """
        
        return Typography(index: 0, size: 64, weight: .bold, lineHeight: 72, content: content)
    }
}
#endif
