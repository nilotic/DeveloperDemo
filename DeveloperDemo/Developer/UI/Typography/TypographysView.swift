//
//  TypographysView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TypographysView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = TypographysData()
    
    
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
        .navigationTitle(DeveloperItem.typography.title)
        .navigationBarTitleDisplayMode(.inline)
        .task { data.request() }
    }
    
    // MARK: Private
    @ViewBuilder
    private var contentView: some View {
        if #available(iOS 17, *) {
            List {
                ForEach($data.sections) { section in
                    Section(isExpanded: section.isExpanded) {
                        ForEach(section.typographys) { typographys in
                            TypographyView(data: typographys)
                        }
                        
                    } header: {
                        TypographyHeaderView(data: section)
                    }
                }
            }
            .listStyle(.sidebar)
            .accentColor(.gray)
            
        } else {
            List($data.sections) { section in
                Section(header: TypographyHeaderView(data: section)) {
                    ForEach(section.typographys) { typographys in
                        TypographyView(data: typographys)
                    }
                }
            }
        }
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        TypographysView()
    }
}
#endif

