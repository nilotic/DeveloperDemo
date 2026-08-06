//
//  DeleteAccountView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeleteAccountView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = DeleteAccountData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            if #available(iOS 26, *) {
                contentView
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            
            } else {
                contentView
            }
            
            if data.isProgressing {
                ProgressView()
            }
        }
        .toolbar {
            trailingBarButtonItem
        }
        .navigationTitle(DeveloperItem.deleteAccount.title)
        .navigationBarTitleDisplayMode(.inline)
        .toast(message: $data.toastMessage)
    }
    
    // MARK: Private
    private var contentView: some View {
        DeletableAccountItemsView(data: data)
            .searchable(text: $data.keyword, prompt: data.searchType.placeholder)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .keyboardType(data.searchType.keyboardType)
            .onSubmit(of: .search) { data.search() }
    }
    
    
    private var trailingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                data.isPresented = true
            
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }
            .confirmationDialog("", isPresented: $data.isPresented, titleVisibility: .hidden) {
                ForEach(DeletableAccountSearchType.allCases) { type in
                    Button(type.title) {
                        data.searchType = type
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    DeleteAccountView()
}
#endif
