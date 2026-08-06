//
//  GooglePlaygroundOAuthView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct GooglePlaygroundOAuthView: View {
    
    // MARK: - Value
    // MARK: Public
    let scope: GooglePlaygroundOAuthScope
    var completion: ((FirebaseToken) -> Void)?
    
    // MARK: Private
    @Environment(\.dismiss) private var dismiss
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        NavigationView {
            Group {
                if #available(iOS 26, *) {
                    contentView
                        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
           
                } else {
                    contentView
                }
            }
            .navigationTitle("Google Playground OAuth")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { leadingBarButtonItem }
        }
    }

    
    // MARK: - View
    // MARK: Private
    private var contentView: some View {
        GooglePlaygroundOAuthViewRepresentable(scope: scope) {
            completion?($0)
            dismiss()
        }
    }
    
    private var leadingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                dismiss()
                
            } label : {
                Image(systemName: "xmark")
            }
        }
    }
}

#if DEBUG
#Preview {
    GooglePlaygroundOAuthView(scope: .remotePush)
}
#endif

