//
//  JSONWebTokenComponentView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct JSONWebTokenComponentView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: JSONWebTokenComponent
    var action: (() -> Void)?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(spacing: 12) {
            headerView
            descriptionView
        }
    }
        
    // MARK: Private
    private var headerView: some View {
        HStack {
            VStack(spacing: 3) {
                Text(data.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if !data.subtitle.isEmpty {
                    Text(data.subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            copyButton
        }
        .frame(minHeight: 40)
    }
    
    private var descriptionView: some View {
        Text(data.description)
            .font(.system(size: 15))
            .foregroundColor(data.color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
    }
    
    private var copyButton: some View {
        Button {
            action?()
            
        } label: {
            Image(systemName: "doc.on.doc")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
#Preview {
    JSONWebTokenComponentView(data: .placeholder)
}
#endif
