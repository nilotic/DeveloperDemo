//
//  ColorPickerData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class ColorPickerData {
    
    // MARK: - Value
    // MARK: Public
    var palettes = [ColorPalette]()
    var isProgressing = false

    private(set) var isWebViewLoadFinished = false
    
    let webData = ColorPickerWebData()
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        isProgressing = true
        
        palettes = [ColorPalette(index: 0, name: "Purple 900", color: Color(.displayP3, red: 95 / 255,  green: 0,         blue: 128 / 255)),
                    ColorPalette(index: 1, name: "Purple 300", color: Color(.displayP3, red: 219 / 255, green: 181 / 255, blue: 255 / 255)),
                    ColorPalette(index: 2, name: "Orange 900", color: Color(.displayP3, red: 249 / 255, green: 103 / 255, blue: 55 / 255)),
                    ColorPalette(index: 3, name: "Orange 300", color: Color(.displayP3, red: 253 / 255, green: 194 / 255, blue: 175 / 255)),
                    ColorPalette(index: 4, name: "Gray 900",   color: Color(.displayP3, red: 51 / 255,  green: 51 / 255,  blue: 51 / 255)),
                    ColorPalette(index: 5, name: "Gray 300",   color: Color(.displayP3, red: 237 / 255, green: 240 / 255, blue: 242 / 255))]
    }
    
    func update() {
        isProgressing = false
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.9)) {
            isWebViewLoadFinished = true
        }
    }
}
