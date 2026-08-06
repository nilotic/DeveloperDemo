//
//  PlaceholderFeatureView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

/// 외부 SDK 가 필요해 이 데모에 포함하지 않은 항목의 자리표시 화면.
struct PlaceholderFeatureView: View {

    // MARK: - Value
    // MARK: Public
    let item: DeveloperItem
    let reason: String


    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: item.imageName)
                .font(.system(size: 36))
                .foregroundStyle(.tertiary)

            Text(item.title)
                .font(.system(size: 17, weight: .semibold))

            Text("이 데모에 포함되지 않은 항목입니다.\n\(reason)")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
#Preview {
    PlaceholderFeatureView(item: .seasonalEvent, reason: "Lottie 필요")
}
#endif
