//
//  ColorPalettesView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPalettesView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = ColorPalettesData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        Group {
            if #available(iOS 26, *) {
                contentView
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                
            } else {
                contentView
            }
        }
        .navigationTitle(data.type.description)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            trailingBarButtonItem
        }
        .task { data.request() }
    }
    
    // MARK: Private
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 60) {
                ForEach($data.sections) {
                    ColorPaletteSectionView(data: $0)
                }
            }
            .padding(.vertical, 20)
        }
        .animation(.smooth, value: data.type)
        .id(data.type)
    }
    
    
    private var trailingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                data.isPresented = true
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .contentShape(Rectangle())
            .confirmationDialog("", isPresented: $data.isPresented, titleVisibility: .hidden) {
                ForEach(ColorPaletteType.allCases) { type in
                    Button(type.description) { data.update(type: type) }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationView {
        ColorPalettesView()
    }
}
#endif
