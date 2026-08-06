//
//  LocalPushesView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct LocalPushesView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = LocalPushesData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack {
            if #available(iOS 18, *) {
                contentView
                    .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            
            } else {
                contentView
            }
            
            if data.isProgressing {
                ProgressView()
            }
        }
        .navigationTitle(DeveloperItem.localPushes.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            trailingBarButtonItem
        }
        .sheet(isPresented: $data.isRegisterViewPresented) {
            if #available(iOS 16, *) {
                LocalPushRegisterView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            data.request()
        }
        .onChange(of: data.isRegisterViewPresented) {
            guard !$0 else { return }
            data.request()
        }
        .toast(message: $data.toastMessage)
        .task {
            data.request()
        }
    }
    
    // MARK: Private
    @ViewBuilder
    private var contentView: some View {
        itemsView
        emptyView
        settingsGuideView
    }
    
    @ViewBuilder
    private var itemsView: some View {
        if !data.isProgressing, !data.sections.isEmpty, data.isAlertAuthorized {
            if #available(iOS 17, *) {
                List {
                    ForEach($data.sections) { $section in
                        Section(isExpanded: $section.isExpanded) {
                            ForEach(section.items) { item in
                                LocalPushItemView(data: item)
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            data.unregister(item: item)
                                            
                                        } label: {
                                            Label("unregister", systemImage: "trash")
                                        }
                                    }
                            }
                            
                        } header: {
                            LocalPushHeaderView(data: section)
                        }
                    }
                }
                .listStyle(.sidebar)
                .accentColor(.gray)
                
            } else {
                List(data.sections) { section in
                    Section(header: LocalPushHeaderView(data: section)) {
                        ForEach(section.items) { item in
                            LocalPushItemView(data: item)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        data.unregister(item: item)
                                        
                                    } label: {
                                        Label("unregister", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var emptyView: some View {
        if !data.isProgressing, data.sections.isEmpty, data.isAlertAuthorized {
            ZStack {
                Color.white
                
                VStack(spacing: 20) {
                    Image(systemName: "mail.stack")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .foregroundColor(Color(.displayP3, red: 165 / 255, green: 165 / 255, blue: 165 / 255))
                    
                    Text("noLocalPushes")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(.displayP3, red: 141 / 255, green: 145 / 255, blue: 159 / 255))
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    private var settingsGuideView: some View {
        if !data.isAlertAuthorized {
            ZStack {
                PushNotificationSettingGuideView {
                    guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
                    UIApplication.shared.open(url, options: [:])
                }
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    
    private var trailingBarButtonItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                data.isRegisterViewPresented = true
                
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

#if DEBUG
#Preview {
    LocalPushesView()
}
#endif
