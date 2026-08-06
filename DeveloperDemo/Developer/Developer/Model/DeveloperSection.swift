//
//  DeveloperSection.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeveloperSection  {
    let title: LocalizedStringKey
    let items: [DeveloperItem]
    var isExpanded = true
}

extension DeveloperSection: Identifiable {
    
    var id: String {
        "\(title)\(items.map(\.id).joined())\(isExpanded)"
    }
}

extension DeveloperSection: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension DeveloperSection: Equatable {
    
    static func == (lhs: DeveloperSection, rhs: DeveloperSection) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension DeveloperSection {
    
    static var placeholder: DeveloperSection {
        DeveloperSection(title: "design", items: [.colorPalette])
    }
}

#endif
