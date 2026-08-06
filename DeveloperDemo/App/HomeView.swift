//
//  HomeView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    // MARK: - View
    // MARK: Public
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("홈")
        }
    }

    // MARK: Private
    private var contentView: some View {
        List {
            Section("추천") {
                ForEach(0..<6, id: \.self) {
                    HomeRowView(index: $0)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}

#if DEBUG
#Preview {
    HomeView()
}
#endif
