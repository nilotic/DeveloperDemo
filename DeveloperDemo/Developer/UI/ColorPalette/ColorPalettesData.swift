//
//  ColorPalettesData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class ColorPalettesData {
    
    // MARK: - Value
    // MARK: Public
    var sections = [ColorPaletteSection]()
    private(set) var type: ColorPaletteType = .service
    
    var isPresented = false
    
    // MARK: Private
    private let brandSections: [ColorPaletteSection] = [.primary, .brand, .neutral, .grayscale, .semantic, .benefit, .tooltip, .element]
    private let designSystemSections: [ColorPaletteSection] = [.dsPrimary, .dsSecondary, .dsBlackAndWhite, .dsGray, .dsPurple, .dsOrange]
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        sections = brandSections
    }
    
    func update(type: ColorPaletteType) {
        self.type = type
        self.sections = type == .service ? brandSections : designSystemSections
    }
}
