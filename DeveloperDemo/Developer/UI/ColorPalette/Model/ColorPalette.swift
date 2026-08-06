//
//  ColorPalette.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPalette {
    let index: UInt
    var name: String
    var color: Color
    let originalColor: Color
}

extension ColorPalette {
    
    init(index: UInt, name: String, color: Color) {
        self.index = index
        self.name  = name
        self.color = color
        
        originalColor = color
    }
}

extension ColorPalette: Identifiable {
    
    var id: String {
        name
    }
}

extension ColorPalette: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ColorPalette: Equatable {
    
    static func ==(lhs: ColorPalette, rhs: ColorPalette) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension ColorPalette {
    
    static var placeholder: ColorPalette {
        ColorPalette(index: 0, name: "primary violet", color: Color("violet0"))
    }
}
#endif
