//
//  DeveloperHeaderView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeveloperHeaderView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: DeveloperSection
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        titleView
            .padding(.bottom, 8)
    }
    
    // MARK: Private
    private var titleView: some View {
        Text(data.title)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(Color(.displayP3, red: 153 / 255, green: 153 / 255, blue: 153 / 255))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    Section(header: DeveloperHeaderView(data: .placeholder)) {
        
    }
}
#endif
