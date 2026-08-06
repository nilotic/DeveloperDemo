//
//  DeveloperView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeveloperView: View {
    
    // MARK: - Value
    @State private var data = DeveloperData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        contentView
            .navigationTitle("developer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
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
                            NavigationLink(destination: destination(item: item)) {
                                DeveloperItemView(data: item)
                            }
                        }
                        
                    } header: {
                        DeveloperHeaderView(data: section)
                    }
                }
            }
            .listStyle(.sidebar)
            .accentColor(.gray)
            .toolbarBackground(.hidden, for: .navigationBar)
            
        } else {
            List {
                ForEach(data.sections) { section in
                    Section(section.title) {
                        ForEach(section.items) { item in
                            NavigationLink(destination: destination(item: item)) {
                                DeveloperItemView(data: item)
                            }
                        }
                    }
                }
            }
        }
    }
        
    // MARK: - Fucntion
    // MARK: Private
    @ViewBuilder
    private func destination(item: DeveloperItem) -> some View {
        switch item {
        case .hosts:                        HostsView()
        case .signature:                    SignatureView()
        case .localPushes:                  LocalPushesView()
        case .remotePush:                   RemotePushView()
        case .jsonWebToken:                 JSONWebTokenView()
        case .socialAccountInformation:     SocialAccountInformationView()
        case .emailWhitelist:               EmailWhitelistView()
        case .lockAccount:                  LockAccountView()
        case .deleteAccount:                DeleteAccountView()
        case .deeplink:                     DeeplinkerView()
        case .colorPalette:                 ColorPalettesView()
        case .colorPicker:                  ColorPickerView()
        case .typography:                   TypographysView()
        case .imageContentMode:             ImageContentModeView()
        case .haptic:                       HapticView()
        case .seasonalEvent:                SeasonalEventView()
        case .appIcon:                      AppIconsView()
        case .growthBook:                   FeatureResultView()
        }
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        DeveloperView()
    }
}
#endif
