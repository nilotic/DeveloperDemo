//
//  DeletableAccountItemsView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeletableAccountItemsView: View {
    
    // MARK: - Value
    // MARK: Private
    var data: DeleteAccountData
    @Environment(\.dismissSearch) private var dismissSearch
    
    
    // MARK: - View
    // MARK: Pubilc
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            itemsView
            emptyView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    // MARK: Private
    @ViewBuilder
    private var itemsView: some View {
        if !data.isEmpty {
            List {
                accountItemsView
                withdrawalAccountItemsView
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    @ViewBuilder
    private var accountItemsView: some View {
        if !data.deletableAccountItems.isEmpty {
            Section("member") {
                ForEach(data.deletableAccountItems) { item in
                    DeletableAccountItemView(data: item)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                data.delete(item: item)
                                
                            } label: {
                                Label("delete", systemImage: "trash")
                            }
                            
                            Button {
                                data.withdraw(item: item)
                                
                            } label: {
                                Label("withdraw", systemImage: "person.2.slash.fill")
                            }
                            .tint(.yellow)
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var withdrawalAccountItemsView: some View {
        if !data.withdrawalAccountItems.isEmpty {
            Section("withdrawalMembers") {
                ForEach(data.withdrawalAccountItems) { item in
                    WithdrawalAccountItemView(data: item)
                        .swipeActions(edge: .trailing) {
                            Button {
                                data.removeWithdrawalAccount(item: item)
                                
                            } label: {
                                Label("delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var emptyView: some View {
        if !data.isProgressing, data.isEmpty, !data.searchedKeyword.isEmpty {
            ZStack {
                Color.white
                
                VStack(spacing: 20) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                    
                    Text("noSearchMemberResults")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(.displayP3, red: 141 / 255, green: 145 / 255, blue: 159 / 255))
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                dismissSearch()
            }
        }
    }
}

#if DEBUG
#Preview {
    DeletableAccountItemsView(data: DeleteAccountData())
}
#endif
