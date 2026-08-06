//
//  DeveloperItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeveloperItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: DeveloperItem
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 16) {
            imageView
            titleView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
    
    // MARK: Private
    private var imageView: some View {
        Image(systemName: data.imageName)
            .resizable()
            .scaledToFit()
            .foregroundColor(data.imageColor)
            .frame(width: 22, height: 22)
    }
    
    private var titleView: some View {
        Text(data.title)
            .foregroundColor(data.titleColor)
    }
}

#if DEBUG
#Preview {
    List(DeveloperItem.allCases) {
        DeveloperItemView(data: $0)
    }
}
#endif
