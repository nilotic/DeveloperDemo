//
//  JSONWebTokenView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct JSONWebTokenView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = JSONWebTokenData()
    
    
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
        .toast(message: $data.toastMessage)
        .navigationTitle(DeveloperItem.jsonWebToken.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            trailingBarButtonItem
        }
        .task { data.request() }
    }
    
    // MARK: Private
    private var contentView: some View {
        Form {
            encodedSectionView
            decodedSectionView
        }
    }
        
    private var encodedSectionView: some View {
        Section("encoded") {
            JSONWebTokenEditorView(text: $data.text) {
                data.clearToken()
                
            } copyAction: {
                data.copyToken()
            }
        }
    }
       
    private var decodedSectionView: some View {
        Section("decoded") {
            VStack(spacing: 25) {
                ForEach(Array(data.components.enumerated()), id: \.element) { i, component in
                    JSONWebTokenComponentView(data: component) {
                        data.copy(component: component)
                    }
                    
                    if i < (data.components.count - 1) {
                        Divider()
                    }
                }
            }
            .padding(.vertical, 10)
        }
    }
    
    
    private var trailingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if #available(iOS 17, *) {
                doneButton
                    .symbolEffect(.bounce.down, value: data.token == nil)
                
            } else {
                doneButton
            }
        }
    }
    
    private var doneButton: some View {
        Button {
            data.updateToken()
            
        } label: {
            Group {
                if #available(iOS 26, *) {
                    Image(systemName: "checkmark")
                    
                } else {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
            }
            .foregroundStyle(data.token == nil ? .mainSecondary : .green700)
        }
        .opacity(data.token == nil ? 0.2 : 1)
        .disabled(data.token == nil)
    }
}

#if DEBUG
#Preview {
    JSONWebTokenView()
}
#endif
