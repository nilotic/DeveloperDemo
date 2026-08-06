//
//  HapticItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HapticItemView: View {
        
    // MARK: - Value
    // MARK: Public
    let data: HapticItem
    var hapticAction: (() -> Void)?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 16) {
            titleView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            hapticAction?()
        }
    }
    
    // MARK: Private    
    private var titleView: some View {
        Text(data.title)
            .foregroundColor(data.titleColor)
    }
}

#if DEBUG
#Preview {
    HapticItemView(data: .placeholder)
}#endif
