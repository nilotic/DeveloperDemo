//
//  DeeplinkItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeeplinkItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: DeeplinkItem
    
    var deeplinkAction: (() -> Void)?
    var editAction: (() -> Void)?
    var copyAction: (() -> Void)?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 10) {
                titleView
                deeplinkView
            }
            
            versionView
            editButton
            copyButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            deeplinkAction?()
        }
    }
    
    // MARK: Private
    private var titleView: some View {
        Text(String(localized: String.LocalizationValue(data.title)))
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var deeplinkView: some View {
        Text(data.deeplink.absoluteString)
            .font(.system(size: 15))
            .foregroundColor(Color(.displayP3, red: 0 / 255, green: 133 / 255, blue: 255 / 255))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var versionView: some View {
        Text("v\(data.version)")
            .font(.system(size: 12))
            .foregroundColor(Color(.displayP3, red: 126 / 255, green: 67 / 255, blue: 250 / 255))
    }
    
    @ViewBuilder
    private var editButton: some View {
        if data.isEditable {
            Button {
                editAction?()
                
            } label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
                    .frame(width: 22, height: 22)
            }
            .buttonStyle(.plain)
        }
    }
    
    private var copyButton: some View {
        Button {
            copyAction?()
            
        } label: {
            Image(systemName: "doc.on.doc")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
                .frame(width: 24, height: 24)
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
#Preview {
    let couponCode = "%EB%9F%AD%EC%85%94%EB%A6%AC%EC%9C%84%ED%81%AC"
    let couponNumber = "%EB%9F%AD%EC%85%94%EB%A6%AC%EC%9C%84%ED%81%AC"
    let couponDeeplink = Deeplink(host: .myPage, path: .coupon, components: [.code: couponCode,
                                                                                   .couponNumber: couponNumber])
    return List {
        Section(header: DeeplinkHeaderView(data: .placeholder)) {
            DeeplinkItemView(data: .placeholder)
            DeeplinkItemView(data: DeeplinkItem(title: "쿠폰 등록 + 코드", deeplink: couponDeeplink, version: "205.12.4"))
        }
    }
}
#endif
