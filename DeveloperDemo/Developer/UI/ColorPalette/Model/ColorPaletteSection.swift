//
//  ColorPaletteSection.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPaletteSection {
    let title: String
    var colorPalettes: [ColorPalette]
}

extension ColorPaletteSection: Identifiable {
    
    var id: String {
        title
    }
}

extension ColorPaletteSection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ColorPaletteSection: Equatable {
    
    static func ==(lhs: ColorPaletteSection, rhs: ColorPaletteSection) -> Bool {
        lhs.id == rhs.id
    }
}

extension ColorPaletteSection {
    
    // MARK: - Demo
    static var primary: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "brandPurple", color: Color("brandPurple"))]
        
        return ColorPaletteSection(title: "Primary", colorPalettes: colorPalettes)
    }
    
    static var brand: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "loversThePurple", color: Color("loversThePurple")), ColorPalette(index: 1, name: "loversPurple", color: Color("loversPurple")),
                             ColorPalette(index: 2, name: "loversLavender",  color: Color("loversLavender")),  ColorPalette(index: 3, name: "loversWhite",  color: Color("loversWhite")),
                             ColorPalette(index: 4, name: "loversFriends",   color: Color("loversFriends"))]
        
        return ColorPaletteSection(title: "Brand", colorPalettes: colorPalettes)
    }
    
    static var neutral: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "shadowGray",  color: Color("shadowGray")),  ColorPalette(index: 1, name: "numBg",        color: Color("numBg")),
                             ColorPalette(index: 2, name: "lightGray",   color: Color("lightGray")),   ColorPalette(index: 3, name: "btnGray",      color: Color("btnGray")),
                             ColorPalette(index: 4, name: "bg",          color: Color("bg")),          ColorPalette(index: 5, name: "defaultTagBg", color: Color("defaultTagBg")),
                             ColorPalette(index: 6, name: "bgLightGray", color: Color("bgLightGray")), ColorPalette(index: 7, name: "tabBg",        color: Color("tagBg"))]
        
        return ColorPaletteSection(title: "Neutral", colorPalettes: colorPalettes)
    }
    
    static var grayscale: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0,  name: "brandWhite",   color: Color("brandWhite")),   ColorPalette(index: 1,  name: "gray100", color: Color("gray100")),
                             ColorPalette(index: 2,  name: "gray150", color: Color("gray150")), ColorPalette(index: 3,  name: "gray200", color: Color("gray200")),
                             ColorPalette(index: 4,  name: "gray250", color: Color("gray250")), ColorPalette(index: 5,  name: "gray300", color: Color("gray300")),
                             ColorPalette(index: 6,  name: "gray350", color: Color("gray350")), ColorPalette(index: 7,  name: "gray400", color: Color("gray400")),
                             ColorPalette(index: 8,  name: "gray450", color: Color("gray450")), ColorPalette(index: 9,  name: "gray500", color: Color("gray500")),
                             ColorPalette(index: 10, name: "gray600", color: Color("gray600")), ColorPalette(index: 11, name: "gray700", color: Color("gray700")),
                             ColorPalette(index: 12, name: "gray800", color: Color("gray800")), ColorPalette(index: 13, name: "gray900", color: Color("gray900")),
                             ColorPalette(index: 14, name: "brandBlack",   color: Color("brandBlack"))]
        
        return ColorPaletteSection(title: "Grayscale", colorPalettes: colorPalettes)
    }
    
    static var semantic: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "validBlue",   color: Color("validBlue")), ColorPalette(index: 1, name: "invalidRed", color: Color("invalidRed")),
                             ColorPalette(index: 2, name: "toastFailBg", color: Color("toastFailBg"))]
        
        return ColorPaletteSection(title: "Semantic", colorPalettes: colorPalettes)
    }
    
    static var benefit: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "loversTag",   color: Color("loversTag")),   ColorPalette(index: 1, name: "pointText", color: Color("pointText")),
                             ColorPalette(index: 2, name: "pointBorder", color: Color("pointBorder")), ColorPalette(index: 3, name: "point",     color: Color("point"))]
        
        return ColorPaletteSection(title: "Benefit", colorPalettes: colorPalettes)
    }
    
    static var tooltip: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "toolTip", color: Color("toolTip"))]
        
        return ColorPaletteSection(title: "Tooltip", colorPalettes: colorPalettes)
    }
    
    static var element: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "kakaoText", color: Color("kakaoText")), ColorPalette(index: 1, name: "kakaoBtn", color: Color("kakaoBtn")),
                             ColorPalette(index: 2, name: "cold",      color: Color("cold")),      ColorPalette(index: 3, name: "frozen",   color: Color("frozen")),
                             ColorPalette(index: 4, name: "room",      color: Color("room"))
        ]
        
        return ColorPaletteSection(title: "Element", colorPalettes: colorPalettes)
    }
    
    
    // MARK: - Design System
    static var dsPrimary: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "Purple 900", color: Color(.displayP3, red: 95 / 255, green: 0,        blue: 128 / 255)),
                             ColorPalette(index: 1, name: "Gray 900",   color: Color(.displayP3, red: 51 / 255, green: 51 / 255, blue: 51 / 255))]
        
        return ColorPaletteSection(title: "Primary", colorPalettes: colorPalettes)
    }
    
    static var dsSecondary: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "Orange 900", color: Color(.displayP3, red: 249 / 255, green: 103 / 255, blue: 55 / 255))]
        
        return ColorPaletteSection(title: "Secondary", colorPalettes: colorPalettes)
    }
    
    static var dsBlackAndWhite: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0, name: "Black", color: .black),
                             ColorPalette(index: 1, name: "White", color: .white)]
        
        return ColorPaletteSection(title: "Black & White", colorPalettes: colorPalettes)
    }
    
    static var dsGray: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0,  name: "Gray 900", color: Color(.displayP3, red: 51 / 255,  green: 51 / 255,  blue: 51 / 255)),
                             ColorPalette(index: 1,  name: "Gray 800", color: Color(.displayP3, red: 103 / 255, green: 117 / 255, blue: 126 / 255)),
                             ColorPalette(index: 2,  name: "Gray 700", color: Color(.displayP3, red: 151 / 255, green: 164 / 255, blue: 174 / 255)),
                             ColorPalette(index: 3,  name: "Gray 600", color: Color(.displayP3, red: 186 / 255, green: 197 / 255, blue: 204 / 255)),
                             ColorPalette(index: 4,  name: "Gray 500", color: Color(.displayP3, red: 205 / 255, green: 213 / 255, blue: 220 / 255)),
                             ColorPalette(index: 5,  name: "Gray 400", color: Color(.displayP3, red: 219 / 255, green: 225 / 255, blue: 230 / 255)),
                             ColorPalette(index: 6,  name: "Gray 300", color: Color(.displayP3, red: 237 / 255, green: 240 / 255, blue: 242 / 255)),
                             ColorPalette(index: 7,  name: "Gray 200", color: Color(.displayP3, red: 244 / 255, green: 246 / 255, blue: 248 / 255)),
                             ColorPalette(index: 8,  name: "Gray 100", color: Color(.displayP3, red: 247 / 255, green: 249 / 255, blue: 251 / 255)),
                             ColorPalette(index: 9,  name: "Gray 50",  color: Color(.displayP3, red: 250 / 255, green: 251 / 255, blue: 252 / 255))]
        
        return ColorPaletteSection(title: "Gray", colorPalettes: colorPalettes)
    }
    
    static var dsPurple: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0,  name: "Purple 900", color: Color(.displayP3, red: 95 / 255,  green: 0 / 255,   blue: 128 / 255)),
                             ColorPalette(index: 1,  name: "Purple 800", color: Color(.displayP3, red: 103 / 255, green: 32 / 255,  blue: 145 / 255)),
                             ColorPalette(index: 2,  name: "Purple 700", color: Color(.displayP3, red: 141 / 255, green: 76 / 255,  blue: 196 / 255)),
                             ColorPalette(index: 3,  name: "Purple 600", color: Color(.displayP3, red: 165 / 255, green: 97 / 255,  blue: 225 / 255)),
                             ColorPalette(index: 4,  name: "Purple 500", color: Color(.displayP3, red: 189 / 255, green: 118 / 255, blue: 255 / 255)),
                             ColorPalette(index: 5,  name: "Purple 400", color: Color(.displayP3, red: 204 / 255, green: 150 / 255, blue: 255 / 255)),
                             ColorPalette(index: 6,  name: "Purple 300", color: Color(.displayP3, red: 219 / 255, green: 181 / 255, blue: 255 / 255)),
                             ColorPalette(index: 7,  name: "Purple 200", color: Color(.displayP3, red: 235 / 255, green: 213 / 255, blue: 255 / 255)),
                             ColorPalette(index: 8,  name: "Purple 100", color: Color(.displayP3, red: 242 / 255, green: 228 / 255, blue: 255 / 255)),
                             ColorPalette(index: 9,  name: "Purple 50",  color: Color(.displayP3, red: 248 / 255, green: 241 / 255, blue: 255 / 255))]
        
        return ColorPaletteSection(title: "Purple", colorPalettes: colorPalettes)
    }
    
    static var dsOrange: ColorPaletteSection {
        let colorPalettes = [ColorPalette(index: 0,  name: "Orange 900", color: Color(.displayP3, red: 249 / 255, green: 103 / 255, blue: 55 / 255)),
                             ColorPalette(index: 1,  name: "Orange 800", color: Color(.displayP3, red: 250 / 255, green: 118 / 255, blue: 75 / 255)),
                             ColorPalette(index: 2,  name: "Orange 700", color: Color(.displayP3, red: 250 / 255, green: 133 / 255, blue: 95 / 255)),
                             ColorPalette(index: 3,  name: "Orange 600", color: Color(.displayP3, red: 251 / 255, green: 149 / 255, blue: 115 / 255)),
                             ColorPalette(index: 4,  name: "Orange 500", color: Color(.displayP3, red: 251 / 255, green: 164 / 255, blue: 135 / 255)),
                             ColorPalette(index: 5,  name: "Orange 400", color: Color(.displayP3, red: 252 / 255, green: 179 / 255, blue: 155 / 255)),
                             ColorPalette(index: 6,  name: "Orange 300", color: Color(.displayP3, red: 253 / 255, green: 194 / 255, blue: 175 / 255)),
                             ColorPalette(index: 7,  name: "Orange 200", color: Color(.displayP3, red: 253 / 255, green: 209 / 255, blue: 195 / 255)),
                             ColorPalette(index: 8,  name: "Orange 100", color: Color(.displayP3, red: 254 / 255, green: 225 / 255, blue: 215 / 255)),
                             ColorPalette(index: 9,  name: "Orange 50",  color: Color(.displayP3, red: 254 / 255, green: 240 / 255, blue: 235 / 255))]
        
        return ColorPaletteSection(title: "Orange", colorPalettes: colorPalettes)
    }
}

#if DEBUG
extension ColorPaletteSection {
    
    static var placeholder: ColorPaletteSection {
        brand
    }
}
#endif
