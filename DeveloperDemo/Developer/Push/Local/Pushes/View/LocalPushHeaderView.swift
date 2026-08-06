//
//  LocalPushHeaderView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct LocalPushHeaderView: View {
    
    // MARK: - Value
    // MARK: Public
    var data: LocalPushSection
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 10) {
            thumbnailView
            titleView
        }
        .padding(.bottom, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: Private
    private var thumbnailView: some View {
        Image(systemName: data.imageName)
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.displayP3, red: 34 / 255, green: 34 / 255, blue: 34 / 255))
            .frame(width: 19, height: 19)
    }
    
    private var titleView: some View {
        Text(data.title)
            .font(.headline)
            .foregroundColor(Color(.displayP3, red: 34 / 255, green: 34 / 255, blue: 34 / 255))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    List {
        Section(header: LocalPushHeaderView(data: .placeholder)) {
            
        }
    }
}
#endif

