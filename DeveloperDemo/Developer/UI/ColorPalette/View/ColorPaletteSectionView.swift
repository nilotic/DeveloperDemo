//
//  ColorPaletteSectionView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPaletteSectionView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var data: ColorPaletteSection
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleView
            colorPalettesView
        }
    }
    
    // MARK: Private
    private var titleView: some View {
        Text(data.title)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(Color(.displayP3, red: 34 / 255, green: 34 / 255, blue: 34 / 255))
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
    }
    
    private var colorPalettesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach($data.colorPalettes) {
                    ColorPaletteView(data: $0)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#if DEBUG
#Preview {
    ColorPaletteSectionView(data: .constant(.placeholder))
}
#endif
