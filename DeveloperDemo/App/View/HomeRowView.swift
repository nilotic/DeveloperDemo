//
//  HomeRowView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HomeRowView: View {

    // MARK: - Value
    // MARK: Public
    let index: Int


    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 12) {
            thumbnailView

            VStack(alignment: .leading, spacing: 4) {
                Text("상품 \(index + 1)")
                    .font(.system(size: 15, weight: .semibold))

                Text("\((index + 1) * 1_900)원")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    // MARK: Private
    private var thumbnailView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.secondary.opacity(0.15))
            .frame(width: 56, height: 56)
            .overlay {
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
            }
    }
}

#if DEBUG
#Preview {
    HomeRowView(index: 0)
}
#endif
