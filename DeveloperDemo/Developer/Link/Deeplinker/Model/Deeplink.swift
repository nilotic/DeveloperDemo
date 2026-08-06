//
//  Deeplink.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Deeplink {
    let host: DeeplinkHost
    var path: DeeplinkPath?
    var components: [DeeplinkKey: String]?
}

extension Deeplink {
    
    init?(url: URL) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = DeeplinkHost(rawValue: urlComponents.host ?? "") else { return nil }
        // Host
        self.host = host
        
        // Path
        path = DeeplinkPath(rawValue: urlComponents.path)
        
        // Components
        guard let queryItems = urlComponents.queryItems else { return }
        components = queryItems.reduce([DeeplinkKey: String]()) { result, queryItem in
            guard let key = DeeplinkKey(rawValue: queryItem.name) else { return result }
            var result = result
            result[key] = queryItem.value
            
            return result
        }
    }
}

extension Deeplink {
    
    var url: URL? {
        var urlComponents = URLComponents()
        
        switch host {
        case .applink:
            urlComponents.scheme = "https"
            
        default:
            urlComponents.scheme = "service"
        }
        
        urlComponents.host = host.rawValue
        
        if let path = path?.rawValue {
            urlComponents.path = "/\(path)"
        }
        
        if let components, !components.isEmpty {
            var queryItems = [URLQueryItem]()
        
            for component in components {
                queryItems.append(URLQueryItem(name: component.key.rawValue, value: "\(component.value)"))
            }
            
            urlComponents.queryItems = queryItems
        }
                
        return urlComponents.url
    }
    
    var absoluteString: String {
        url?.absoluteString ?? ""
    }
}

extension Deeplink: Identifiable {
    
    var id: String {
        absoluteString
    }
}

extension Deeplink: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Deeplink: Equatable {
    
    static func ==(lhs: Deeplink, rhs: Deeplink) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension Deeplink {
    
    static var placeholder: Deeplink {
        Deeplink(host: .home, components: [.site: "market"])
    }
}

#endif
