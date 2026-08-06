//
//  AppIconsView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct AppIconsView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = AppIconsData()
    
    
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
        }
        .navigationTitle(DeveloperItem.appIcon.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Private
    @ViewBuilder
    private var contentView: some View {
        if #available(iOS 17, *) {
            thumbnailsView
                .listStyle(.sidebar)
                .accentColor(.gray)
                .toolbarBackground(.hidden, for: .navigationBar)
                .toast(message: $data.toastMessage)
            
        } else {
            thumbnailsView
        }
    }
    
    private var thumbnailsView: some View {
        List(SeasonalEventAppIconType.allCases) { type in
            Button {
                data.handle(type: type)
                
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: type.thumbnailName) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .cornerRadius(9)
                    
                    Text(type.description)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        AppIconsView()
    }
}
#endif
