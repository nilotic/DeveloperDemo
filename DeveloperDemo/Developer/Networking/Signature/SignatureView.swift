//
//  SignatureView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct SignatureView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = SignatureData()
    @FocusState private var focusedField: Int?
    
    
    
    // MARK: - View
    // MARK: Pubilc
    var body: some View {
        Group {
            if #available(iOS 18, *) {
                contentView
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                
            } else {
                contentView
            }
        }
        .navigationTitle(DeveloperItem.signature.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Private
    private var contentView: some View {
        Form {
            statusView
            userAgentView
            // signatureView
            doneButton
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .onChange(of: focusedField) { field in
            guard field != nil else { return }
            data.status = .none
        }
    }
    
    @ViewBuilder
    private var statusView: some View {
        if #available(iOS 18, *) {
            Section {
                Image(systemName: "signature")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 80)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.gray, data.status.symbolColor)
                    .symbolEffect(.bounce, value: data.validationAnimationValue)
                    .symbolEffect(.wiggle, value: data.invalidationAnimationValue)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
        }
    }
    
    private var userAgentView: some View {
        Section("User Agent") {
            TextField(HTTPHeaderField.userAgent.rawValue, text: $data.userAgent)
                .autocapitalization(.none)
                .keyboardType(.asciiCapable)
                .focused($focusedField, equals: 0)
        }
    }
       
    /*private var signatureView: some View {
        Section("Signature") {
            TextField(HTTPHeaderField.service(.signature).rawValue, text: $data.signature)
                .autocapitalization(.none)
                .keyboardType(.asciiCapable)
                .focused($focusedField, equals: 1)
        }
    }*/
    
    private var doneButton: some View {
        Button {
            focusedField = nil
            data.validate()
            
        } label: {
            Text("ok")
                .frame(maxWidth: .infinity)
        }
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        SignatureView()
    }
}
#endif
