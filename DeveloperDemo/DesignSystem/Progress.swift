//
//  Progress.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

/// 진행 중 인디케이터.
struct Progress: View {

    init() {}

    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}

#if DEBUG
#Preview {
    Progress()
}
#endif
