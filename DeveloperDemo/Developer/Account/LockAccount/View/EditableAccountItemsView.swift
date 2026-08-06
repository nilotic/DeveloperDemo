//
//  EditableAccountItemsView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct EditableAccountItemsView: View {
    
    // MARK: - Value
    // MARK: Private
    var data: LockAccountData
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
                lockableAccountItemsView
                unlockableAccountItemsView
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    @ViewBuilder
    private var lockableAccountItemsView: some View {
        if !data.lockableAccountItems.isEmpty {
            Section {
                ForEach(data.lockableAccountItems) { item in
                    EditableAccountItemView(data: item)
                        .swipeActions(edge: .trailing) {
                            Button(role: .cancel) {
                                data.update(item: item, status: .locked)
                                
                            } label: {
                                Label("lock", systemImage: "lock.fill")
                            }
                        }
                        .tint(.pink)
                }
                
            } header: {
                HStack{
                    Image(systemName: "lock.open")
                        .font(.headline)
                    
                    Text("member")
                }
                .padding(.vertical, 3)
            }
        }
    }
    
    @ViewBuilder
    private var unlockableAccountItemsView: some View {
        if !data.unlockableAccountItems.isEmpty {
            Section {
                ForEach(data.unlockableAccountItems) { item in
                    EditableAccountItemView(data: item)
                        .swipeActions(edge: .leading) {
                            Button {
                                data.update(item: item, status: .unlocked)
                                
                            } label: {
                                Label("unlock", systemImage: "lock.open")
                            }
                            .tint(.indigo)
                        }
                }
                
            } header: {
                HStack{
                    Image(systemName: "lock.fill")
                        .font(.headline)
                    
                    Text("member")
                }
                .padding(.vertical, 3)
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
    EditableAccountItemsView(data: LockAccountData())
}
#endif
