//
//  ApplinkHost.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ApplinkHost {
    case service(Server)
    case blog
    case blogStage
    case pick
    case pickStage
    case lounge
    case loungeStage
}

extension ApplinkHost: RawRepresentable {
    
    init?(url: URL) {
        guard let rawValue = URLComponents(url: url, resolvingAgainstBaseURL: false)?.host, let host = ApplinkHost(rawValue: rawValue) else { return nil }
        self = host
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case Host.godo(.development(.none)).rawValue:   self = .service(.development(.none))
        case Host.godo(.stage(.none)).rawValue:         self = .service(.stage(.none))
        case Host.godo(.production).rawValue:           self = .service(.production)
        case Self.blog.rawValue:                    self = .blog
        case Self.blogStage.rawValue:               self = .blogStage
        case Self.pick.rawValue:                    self = .pick
        case Self.pickStage.rawValue:               self = .pickStage
        case Self.lounge.rawValue:                      self = .lounge
        case Self.loungeStage.rawValue:                 self = .loungeStage
        default:                                        return nil
        }
    }
    
    var rawValue: String {
        switch self {
        case .service(let server):    Host.godo(server).rawValue
        case .blog:             "blog.example.com"
        case .blogStage:        "blog.stg.example.com"
        case .pick:             "pick.example.com"
        case .pickStage:        "pick.stg.example.com"
        case .lounge:               "lounge.example.com"
        case .loungeStage:          "lounge.stg.example.com"
        }
    }
}

extension ApplinkHost: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension ApplinkHost: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension ApplinkHost: Equatable {
    
    static func ==(lhs: ApplinkHost, rhs: ApplinkHost) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
