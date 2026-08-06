//
//  TypographyHeaderView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TypographyHeaderView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var data: TypographySection
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack {
            Text(data.title)
                .font(.headline)
                .foregroundColor(Color(.displayP3, red: 34 / 255, green: 34 / 255, blue: 34 / 255))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#if DEBUG
#Preview {
    TypographyHeaderView(data: .constant(.placeholder))
}
#endif
