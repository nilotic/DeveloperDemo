//
//  ServerHostKind.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ServerHostKind: CaseIterable {
    case godo
    case authentication
    case api
    case eventCollector
    case appConfig
    case nowService

    // MARK: Computed properties
    var name: String {
        switch self {
        case .api:
            return "API"
        case .authentication:
            return "Authentication"
        case .godo:
            return "Godo"
        case .appConfig:
            return "App Config"
        case .nowService:
            return "service Now"
        case .eventCollector:
            return "User event collector"
        }
    }

    var userDefaultsKey: String {
        switch self {
        case .api:
            return "ServerHostAPI"
        case .authentication:
            return "ServerHostAuthentication"
        case .godo:
            return "ServerHostGodo"
        case .appConfig:
            return "ServerHostAppConfig"
        case .nowService:
            return "ServerHostNowService"
        case .eventCollector:
            return "ServerHostEventCollector"
        }
    }

    var defaultHost: String {
        switch self {
        case .api:
            return "https://api.example.com"
        case .authentication:
            return "https://auth.example.com"
        case .godo:
            return "https://www.example.com"
        case .appConfig:
            return "https://moderate.example.com"
        case .nowService:
            return "https://now.example.com"
        case .eventCollector:
            return "https://kafka-proxy.example.net"
        }
    }

    var currentHost: String {    
        UserDefaults.standard.string(forKey: userDefaultsKey) ?? defaultHost
    }

    var currentHostURL: URL {
        URL(string: currentHost)!
    }

    var isLive: Bool {
        defaultHost == currentHost
    }

    var isDev: Bool {
        currentHost.contains("dev")
    }

    var isPerf: Bool {
        currentHost.contains("perf")
    }

    var isStage: Bool {
        currentHost.contains("stg")
    }
    
    var cookieDomain : String {
        currentHost.replacingOccurrences(of: "https://www", with: "")
    }
    
    func saveAuthDefaultKey() {
        guard !ServerHostKind.api.isLive else { return }
        
        let url: String = if ServerHostKind.api.isDev {
            "https://\(Host.authentication(.development(.none)).rawValue)"
        } else if ServerHostKind.api.isPerf {
            "https://\(Host.authentication(.perf).rawValue)"
        } else if ServerHostKind.api.isStage {
            "https://\(Host.authentication(.stage(.none)).rawValue)"
        } else {
            "https://\(Host.authentication(.production).rawValue)"
        }
        
        UserDefaults.standard.set(url, forKey: ServerHostKind.authentication.userDefaultsKey)
        hosts.synchronize()
        
    }
}
