//
//  EmailWhitelistView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct EmailWhitelistView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = EmailWhitelistData()
    @FocusState private var focusedField: Int?
    
    
    
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
        .navigationTitle(DeveloperItem.emailWhitelist.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            trailingBarButtonItem
        }
        .toast(message: $data.toastMessage)
    }
    
    // MARK: Private
    private var contentView: some View {
        Form {
            emailView
            phoneNumberView
            teamNameView
            registerButton
        }
    }
    
    private var emailView: some View {
        Section("email") {
            TextField("emailPlaceholder", text: $data.email)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .keyboardType(.asciiCapable)
                .focused($focusedField, equals: 0)
        }
    }
    
    private var phoneNumberView: some View {
        Section("phoneNumber") {
            TextField("phoneNumberTextFieldPlaceholder", text: $data.phoneNumber)
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .focused($focusedField, equals: 1)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        if focusedField == 1 {
                            ZStack {
                                Button {
                                    focusedField = nil
                                    
                                } label: {
                                    Text("done")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
        }
    }
    
    private var teamNameView: some View {
        Section("teamName") {
            TextField("teamNamePlaceholder", text: $data.teamName)
                .autocapitalization(.none)
                .focused($focusedField, equals: 2)
        }
    }
    
    private var registerButton: some View {
        Button {
            focusedField = nil
            data.register()
            
        } label: {
            Text("registration")
                .frame(maxWidth: .infinity)
        }
    }
    
    
    private var trailingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            SignInWithAppleButton(.continue) {
                $0.requestedScopes = [.fullName, .email]
                
            } onCompletion: {
                data.handle(result: $0)
            }
            .cornerRadius(15)
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            .overlay {
                ZStack {
                    if #available(iOS 26, *) {
                        Color(.displayP3, red: 0.9843137255, green: 0.9843137255, blue: 1)
                        
                    } else {
                        Color.white
                    }
                    
                    Image(systemName: "apple.logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .offset(y: -2)
                }
                .allowsHitTesting(false)
            }
        }
    }
}

#if DEBUG
#Preview {
    EmailWhitelistView()
}
#endif
