//
//  JSONWebTokenEditorView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct JSONWebTokenEditorView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var text: String
    var clearAction: (() -> Void)?
    var copyAction: (() -> Void)?
    
    // MARK: Private
    @State private var textFieldHeight: CGFloat = 0
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(spacing: 13) {
            encodedSectionHeaderView
            textFieldView
        }
    }
        
    // MARK: Private
    private var encodedSectionHeaderView: some View {
        HStack {
            Text("token")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 15) {
                clearButton
                copyButton
            }
        }
        .frame(height: 40)
    }
    
    @ViewBuilder
    private var textFieldView: some View {
        if #available(iOS 16, *) {
            JSONWebTokenTextField(text: $text)
        }
    }
    
    private var clearButton: some View {
        Button {
            clearAction?()
            
        } label: {
            Image(systemName: "eraser")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.plain)
    }
    
    private var copyButton: some View {
        Button {
            copyAction?()
            
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
    JSONWebTokenEditorView(text: .constant("token1234"))
}
#endif
