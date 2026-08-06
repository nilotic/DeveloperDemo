//
//  HostsView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HostsView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = HostsData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        if #available(iOS 16, *) {
            contentView
                .toolbar {
                    profileToolbarItem
                    
                    if #available(iOS 26, *) {
                        ToolbarSpacer(.fixed)
                    }
                    
                    doneToolbarItem
                }
                
        } else {
            contentView
                .toolbar {
                    profileToolbarItem
                    doneToolbarItem
                }
        }
    }
    
    // MARK: Private
    private var contentView: some View {
        ZStack {
            listView
            
            if data.isProgressing {
                ProgressView()
            }
        }
        .navigationTitle(DeveloperItem.hosts.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert("customHost", isPresented: $data.isAlertPresented) {
            TextField("customHostPlaceholder", text: $data.customHost)
                .keyboardType(.URL)
            
            Button(String(localized: "ok")) { data.updateHost() }
            Button(String(localized: "cancel")) {}
        }
        .alert("customHost", isPresented: $data.isGodoAlertPresented) {
            TextField("customHostPlaceholder", text: $data.customGodoHost)
                .keyboardType(.URL)
            
            Button(String(localized: "ok")) { data.updateGodoHost() }
            Button(String(localized: "cancel")) {}
        }
        .toast(message: $data.toastMessage)
        .task { data.request() }
    }
    
    @ViewBuilder
    private var listView: some View {
        if #available(iOS 17, *) {
            List {
                ForEach($data.sections) { $section in
                    Section(isExpanded: $section.isExpanded) {
                        ForEach(section.items) { item in
                            HostItemView(data: item) {
                                data.edit(item: item)
                                
                            } action: {
                                data.handle(item: item)
                            }
                        }
                        
                    } header: {
                        HostHeaderView(data: section)
                    }
                }
            }
            .listStyle(.sidebar)
            .accentColor(.gray)
            .toolbarBackground(.hidden, for: .navigationBar)
            
        } else {
            List(data.sections) { section in
                Section(header: HostHeaderView(data: section)) {
                    ForEach(section.items) { item in
                        HostItemView(data: item) {
                            data.edit(item: item)
                            
                        } action: {
                            data.handle(item: item)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var settingsView: some View {
        Button(HostSettingType.development.description) {
            data.handle(type: .development)
        }
        
        Button(HostSettingType.stage.description) {
            data.handle(type: .stage)
        }
        
        Button(HostSettingType.perf.description) {
            data.handle(type: .perf)
        }
        
        Button(HostSettingType.production.description) {
            data.handle(type: .production)
        }
        
        Button("cancel", role: .cancel) {
            
        }
    }
    
    
    private var profileToolbarItem: some ToolbarContent {
        if #available(iOS 16, *) {
            ToolbarItem {
                settingButton
            }
            
        } else {
            ToolbarItem(placement: .navigationBarTrailing) {
                settingButton
            }
        }
    }
    
    private var doneToolbarItem: some ToolbarContent {
        ToolbarItem {
            if #available(iOS 17, *) {
                doneButton
                    .symbolEffect(.bounce.down, value: data.isUpdated)
                
            } else {
                doneButton
            }
        }
    }
    
    private var settingButton: some View {
        Button {
            data.isSettingsViewPresented = true
            
        } label: {
            Image(systemName: "doc.badge.gearshape")
                .foregroundStyle(.mainSecondary)
        }
        .disabled(data.sections.isEmpty)
        .confirmationDialog("", isPresented: $data.isSettingsViewPresented, titleVisibility: .hidden) {
            settingsView
        }
    }
    
    private var doneButton: some View {
        Button {
            data.apply()
            
        } label: {
            Group {
                if #available(iOS 26, *) {
                    Image(systemName: "checkmark")
                
                } else {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                }
            }
            .foregroundStyle(data.isUpdated ? .green700 : .mainSecondary)
        }
        .disabled(!data.isUpdated)
        .opacity(data.isUpdated ? 1 : 0.2)
    }
}

#if DEBUG
#Preview {
    NavigationView {
        HostsView()
    }
    .navigationViewStyle(.stack)
}
#endif
