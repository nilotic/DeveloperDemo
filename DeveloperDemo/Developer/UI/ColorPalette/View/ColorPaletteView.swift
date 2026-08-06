//
//  ColorPaletteView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPaletteView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var data: ColorPalette
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            colorView
           
            VStack(alignment: .leading, spacing: 7) {
                nameView
                descriptionView
            }
            .onTapGesture {
                data.color = data.originalColor
            }
        }
    }
    
    // MARK: Private
    private var colorView: some View {
        ZStack {
            data.color
                .padding(.bottom, 8)
            
            ColorPicker("", selection: $data.color, supportsOpacity: true)
        }
        .frame(width: 128, height: 128)
    }
    
    private var nameView: some View {
        Text(data.name)
            .frame(width: 128, alignment: .leading)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(Color(.displayP3, red: 34 / 255, green: 34 / 255, blue: 34 / 255))
            .lineLimit(1)
    }
    
    private var descriptionView: some View {
        Text(String(localizedFormat: "colorPaletteDescription", data.color.hex, data.color.rgba))
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(Color(.displayP3, red: 99 / 255, green: 101 / 255, blue: 112 / 255))
    }
}

#if DEBUG
#Preview {
    ColorPaletteView(data: .constant(.placeholder))
}
#endif
