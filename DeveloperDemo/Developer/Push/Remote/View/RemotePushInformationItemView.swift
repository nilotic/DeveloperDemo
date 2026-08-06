//
//  RemotePushInformationItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct RemotePushInformationItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: RemotePushInformationItem
    var editAction: (() -> Void)?
    var copyAction: (() -> Void)?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(spacing: 12) {
            titleView
        
            HStack(spacing: 25) {
                tokenView
                editButton
                copyButton
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 25)
        .contentShape(Rectangle())
    }
    
    // MARK: Private
    private var titleView: some View {
        Text(data.title)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Color(.displayP3, red: 80 / 255, green: 80 / 255, blue: 80 / 255))
            .multilineTextAlignment(.leading)
            .lineLimit(0)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var tokenView: some View {
        Text(data.token)
            .font(.system(size: 15))
            .foregroundColor(.cyan)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
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
    VStack {
        RemotePushInformationItemView(data: .placeholder)
    }
}
#endif
