//
//  TokenInformationView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TokenInformationView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: [RemotePushInformationItem]
    var completion: ((String) -> Void)?
    
    // MARK: Private
    @State private var toastMessage = ""
    @State private var isAlertPresented = false
    @State private var token = ""
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        if #available(iOS 16, *) {
            contentView
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        
        } else {
            contentView
        }
    }
    
    // MARK: Private
    private var contentView: some View {
        itemsView
            .toast(message: $toastMessage)
            .alert("Firebase Cloud Messaging", isPresented: $isAlertPresented) {
                TextField("Token", text: $token)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button(String(localized: "ok")) { completion?(token) }
                Button(String(localized: "cancel")) {}
            }
    }
    
    private var itemsView: some View {
        ScrollView {
            VStack(spacing: 60) {
                ForEach(data) { item in
                    RemotePushInformationItemView(data: item) {
                        token = ""
                        isAlertPresented = true
                        
                    } copyAction: {
                        UIPasteboard.general.string = item.token
                        toastMessage = "\(item.title) 이 복사되었습니다."
                    }
                }
            }
        }
        .padding(.top, 40)
    }
}

#if DEBUG
#Preview {
    TokenInformationView(data: [.placeholder])
}
#endif
