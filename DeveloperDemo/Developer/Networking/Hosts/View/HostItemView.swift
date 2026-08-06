//
//  HostItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HostItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: HostItem
    var editAction: (() -> Void)?
    var action: (() -> Void)?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 16) {
            radioButton
            
            VStack(spacing: 3) {
                titleView
                hostView
            }
            
            editButton
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
    
    // MARK: Private
    private var radioButton: some View {
        Image(systemName: data.isSelected ? "checkmark.circle.fill" : "circle")
            .resizable()
            .foregroundColor(data.isSelected ? .cyan : Color(.displayP3, red: 217 / 255, green: 217 / 255, blue: 217 / 255))
            .frame(width: 20, height: 20)
            .padding(6)
    }
    
    private var titleView: some View {
        Text(data.title)
            .font(.system(size: 18))
            .foregroundColor(Color(.displayP3, red: 60 / 255, green: 60 / 255, blue: 60 / 255))
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var hostView: some View {
        Text(data.host.rawValue)
            .font(.system(size: 13))
            .foregroundColor(.purple)
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
}

#if DEBUG
#Preview {
    var data = HostItem.placeholder
    data.isSelected = true
    
    return List {
        Section(header: HostHeaderView(data: .placeholder)) {
            HostItemView(data: .placeholder)
            HostItemView(data: data)
        }
    }
}
#endif
