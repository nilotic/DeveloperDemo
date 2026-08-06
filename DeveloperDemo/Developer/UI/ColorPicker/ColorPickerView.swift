//
//  ColorPickerView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPickerView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = ColorPickerData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            if #available(iOS 26, *) {
                contentView
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            
            } else {
                contentView
            }
        
            if data.isProgressing {
                ProgressView()
            }
        }
        .navigationTitle(DeveloperItem.colorPicker.title)
        .navigationBarTitleDisplayMode(.inline)
        .task { data.request() }
    }
    
    // MARK: Private
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 20) {
                webColorPalettesView
                colorPalettesView
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
        .opacity(data.isWebViewLoadFinished ? 1 : 0)
    }
    
    private var webColorPalettesView: some View {
        VStack(spacing: 20) {
            Text("web")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ColorPickerWebView(data: data.webData) {
                data.update()
            }
            .frame(height: 250)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var colorPalettesView: some View {
        VStack(spacing: 20) {
            Text("iOS")
                .font(.system(size: 32, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach($data.palettes) {
                        ColorPaletteView(data: $0)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        ColorPickerView()
    }
}
#endif
