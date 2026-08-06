//
//  DeeplinkerView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeeplinkerView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = DeeplinkerData()
    
    
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
        .navigationTitle(DeveloperItem.deeplink.title)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $data.keyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "deeplinkPlaceholder")
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .alert(data.textFieldAlert.title, isPresented: $data.isAlertPresented) {
            TextFieldAlertView(data: data)
        }
        .toast(message: $data.toastMessage)
        .task { data.request() }
    }
    
    // MARK: Private
    @ViewBuilder
    private var contentView: some View {
        if #available(iOS 17, *) {
            List {
                ForEach($data.sections) { $section in
                    Section(isExpanded: $section.isExpanded) {
                        ForEach(section.items) { item in
                            DeeplinkItemView(data: item) {
                                data.handle(item: item)

                            } editAction: {
                                data.edit(item: item)
                            
                            } copyAction: {
                                data.copy(item: item)
                            }
                        }
                    
                    } header: {
                        DeeplinkHeaderView(data: section)
                    }
                }
            }
            .listStyle(.sidebar)
            .accentColor(.gray)
            
        } else {
            List(data.sections) { section in
                Section(header: DeeplinkHeaderView(data: section)) {
                    ForEach(section.items) { item in
                        DeeplinkItemView(data: item) {
                            data.handle(item: item)
                            
                        } editAction: {
                            data.edit(item: item)
                            
                        } copyAction: {
                            data.copy(item: item)
                        }
                    }
                }
            }
        }
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        DeeplinkerView()
    }
}
#endif
