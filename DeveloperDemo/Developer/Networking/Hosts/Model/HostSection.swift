//
//  HostSection.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HostSection {
    let title: String
    var items: [HostItem]
    var isExpanded = true
}

extension HostSection {
    
    var imageName: String {
        guard let host = items.first?.host else { return "" }
        switch host {
        case .api:                      return "server.rack"
        case .authentication:           return "key"
        case .godo:                     return "globe"
        case .backOffice:               return "building.2"
        case .commerce:                 return "scroll"
        case .nowService:                 return "building.2"
        case .appConfiguration:         return "wrench.and.screwdriver"
        case .eventConfiguration:       return "gift"
        case .googleDeveloper:          return "cloud"
        case .googleAccount:            return "cloud"
        case .googleAPI:                return "cloud"
        case .firebaseCloudMessaging:   return "cloud"
        }
    }
}

extension HostSection: Identifiable {
    
    var id: String {
        "\(title)\(items.map(\.id).joined())\(isExpanded)"
    }
}

extension HostSection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension HostSection: Equatable {
    
    static func == (lhs: HostSection, rhs: HostSection) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension HostSection {
    
    static var placeholder: HostSection {
        let items = [HostItem(host: .api(.development(.none)), indexPath: IndexPath(row: 0, section: 0), isSelected: true),
                     
                     HostItem(host: .api(.stage(.none)), indexPath: IndexPath(row: 1, section: 0), isSelected: false),
                     
                     HostItem(host: .api(.twoCC), indexPath: IndexPath(row: 2, section: 0), isSelected: false),
                     HostItem(host: .api(.perf), indexPath: IndexPath(row: 3, section: 0), isSelected: false),
                     
                     HostItem(host: .api(.custom("api.custom.example.com")), indexPath: IndexPath(row: 4, section: 0), isSelected: true),
                     HostItem(host: .api(.production), indexPath: IndexPath(row: 5, section: 0), isSelected: false),
        ]
        
        return HostSection(title: "API", items: items)
    }
}
#endif
