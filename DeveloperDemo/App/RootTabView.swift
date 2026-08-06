//
//  RootTabView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct RootTabView: View {

    // MARK: - View
    // MARK: Public
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house")
                }

            MoreView()
                .tabItem {
                    Label("더보기", systemImage: "ellipsis")
                }
        }
    }
}

#if DEBUG
#Preview {
    RootTabView()
}
#endif
