//
//  HostItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct HostItem {
    let title: String
    var host: Host
    let indexPath: IndexPath
    var isSelected = false
}

extension HostItem {
    
    var isEditable: Bool {
        switch host {
        case .api(let server):
            switch server {
            case .custom:       return true
            default:            return false
            }
        case .godo(let server):
            switch server {
            case .custom:       return true
            default:            return false
            }
            
        default:                return false
        }
    }
}

extension HostItem: RawRepresentable {
    
    init(host: Host, indexPath: IndexPath, isSelected: Bool) {
        title = host.server.debugDescription
        
        self.host = host
        self.indexPath = indexPath
        self.isSelected = isSelected
    }
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "|")
        
        guard components.count == 4, let host = Host(rawValue: components[1]), let section = Int(components[2]), let row = Int(components[3]) else { return nil }
        title = components[0]
        indexPath = IndexPath(row: row, section: section)
        
        self.host = host
    }

    var rawValue: String {
        "\(title)|\(host.rawValue)|\(indexPath.section)|\(indexPath.row)"
    }
}

extension HostItem: Identifiable {
    
    var id: String {
        "\(rawValue)|\(isSelected)"
    }
}

extension HostItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension HostItem: Equatable {
    
    static func == (lhs: HostItem, rhs: HostItem) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension HostItem {
    
    static var placeholder: HostItem {
        HostItem(host: .api(.production), indexPath: IndexPath(row: 0, section: 0), isSelected: false)
    }
}
#endif
