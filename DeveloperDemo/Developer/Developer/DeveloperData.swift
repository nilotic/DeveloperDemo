//
//  DeveloperData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class DeveloperData {
    
    // MARK: - Value
    // MARK: Public
    var sections = [DeveloperSection]()
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        sections = [DeveloperSection(title: "networking", items: [.hosts, .signature]),
                    DeveloperSection(title: "push", items: [.localPushes, .remotePush]),
                    DeveloperSection(title: "account", items: [.jsonWebToken, .socialAccountInformation, .emailWhitelist, .lockAccount, .deleteAccount]),
                    DeveloperSection(title: "link", items: [.deeplink]),
                    DeveloperSection(title: "featureFlag", items: [.growthBook]),
                    DeveloperSection(title: "ui", items: [.colorPalette, .colorPicker, .typography, .imageContentMode]),
                    DeveloperSection(title: "ux", items: [.haptic]),
                    DeveloperSection(title: "configuration", items: [.seasonalEvent, .appIcon])]
    }
}
