//
//  RemotePushView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct RemotePushView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = RemotePushData()
    @FocusState private var focusedField: Int?
    
    
    
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
        .navigationTitle(DeveloperItem.remotePush.title)
        .navigationBarTitleDisplayMode(.inline)
        .toast(message: $data.toastMessage)
        .toolbar {
            trailingBarButtonItem
        }
        .sheet(isPresented: $data.isInformationViewPresented) {
            TokenInformationView(data: data.items) {
                data.update(token: $0)
            }
        }
        .sheet(isPresented: $data.isGooglePlaygroundOAuthViewPresented) {
            GooglePlaygroundOAuthView(scope: .remotePush) {
                data.handle(token: $0)
            }
        }
        .task {
            data.request()
        }
    }
    
    // MARK: Private
    @ViewBuilder
    private var contentView: some View {
        Form {
            alertView
            settings
            sendButton
        }
    }
    
    private var alertView: some View {
        Section("notification") {
            TextField("title", text: $data.title)
                .autocapitalization(.none)
                .focused($focusedField, equals: 0)
            
            TextField("subtitle", text: $data.subtitle)
                .autocapitalization(.none)
                .focused($focusedField, equals: 1)
            
            TextField("body", text: $data.body)
                .autocapitalization(.none)
                .focused($focusedField, equals: 2)
            
            TextField("imageURL", text: $data.imageURL)
                .autocapitalization(.none)
                .keyboardType(.URL)
                .foregroundColor(.blue)
                .focused($focusedField, equals: 3)
            
            TextField("link", text: $data.link)
                .autocapitalization(.none)
                .keyboardType(.URL)
                .foregroundColor(.blue)
                .focused($focusedField, equals: 4)
        }
    }
    
    private var settings: some View {
        Section("settings") {
            Picker("thread", selection: $data.thread) {
                ForEach(PushThread.allCases) {
                    Text($0.description)
                        .tag($0)
                }
            }
            
            Picker("category", selection: $data.category) {
                ForEach(RemotePushCategory.allCases) {
                    Text($0.description)
                        .tag($0)
                }
            }
            
            Picker("notificationSound", selection: $data.sound) {
                ForEach(data.sounds, id: \.self.1) {
                    Text("\($0.0)")
                        .tag($0.1)
                }
            }
            
            Picker("interruptionLevel", selection: $data.interruptionLevel) {
                ForEach(data.interruptionLevels, id: \.self.1) {
                    Text("\($0.0)")
                        .tag($0.1)
                }
            }
            
            Picker("priority", selection: $data.apnsPriority) {
                ForEach(UInt(0)...UInt(10), id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }
            
            Picker("badge", selection: $data.badge) {
                ForEach(UInt(0)...UInt(10), id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }
        }
    }
    
    private var sendButton: some View {
        Button {
            focusedField = nil
            data.send()
            
        } label: {
            Text("send")
                .frame(maxWidth: .infinity)
        }
    }
    
    
    private var trailingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Info", systemImage: "info") {
                data.isInformationViewPresented = true
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationView {
        RemotePushView()
    }
}
#endif
