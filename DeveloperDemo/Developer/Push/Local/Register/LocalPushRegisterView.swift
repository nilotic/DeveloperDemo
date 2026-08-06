//
//  LocalPushRegisterView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import PhotosUI

@available(iOS 16, *)
struct LocalPushRegisterView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = LocalPushRegisterData()
    @FocusState private var focusedField: Int?
    
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
            .navigationTitle("registration")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                trailingBarButtonItem
            }
            .onChange(of: data.isRegistered) {
                guard $0 else { return }
                dismiss()
            }
            .toast(message: $data.toastMessage)
            .task { data.request() }
        }
    }
    
    // MARK: Private
    private var contentView: some View {
        Form {
            alertView
            settings
            triggerView
            registerButton
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
            
            TextField("deeplink", text: $data.deeplink)
                .autocapitalization(.none)
                .focused($focusedField, equals: 3)
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
            
            Picker("notificationSound", selection: $data.sound) {
                ForEach(data.sounds, id: \.self.1) {
                    Text("\($0.0)")
                        .tag($0.1)
                }
            }
            
            Picker("badge", selection: $data.badge) {
                ForEach(UInt(0)...UInt(10), id: \.self) {
                    Text("\($0)")
                        .tag($0)
                }
            }
            
            Picker("interruptionLevel", selection: $data.interruptionLevel) {
                ForEach(data.interruptionLevels, id: \.self.1) {
                    Text("\($0.0)")
                        .tag($0.1)
                }
            }
        }
    }
    
    private var triggerView: some View {
        Section("trigger") {
            VStack(spacing: 0) {
                Text("timeInterval")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TimerPickerView(hours: $data.hours, minutes: $data.minutes, seconds: $data.seconds)
            }
            .padding(.bottom, 5)
            
            Toggle("repeat", isOn: $data.isRepeats)
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
            PhotosPicker(selection: $data.photosPickerItem, photoLibrary: .shared()) {
                imageView
            }
        }
    }
    
    @ViewBuilder
    private var imageView: some View {
        if let url = data.attachment?.url {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(6)
            
        } else  {
            Image(systemName: "photo")
        }
    }
}

#if DEBUG
@available(iOS 16, *)
#Preview {
    LocalPushRegisterView()
}
#endif
