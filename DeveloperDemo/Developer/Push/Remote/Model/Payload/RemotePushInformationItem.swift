//
//  RemotePushInformationItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct RemotePushInformationItem {
    let title: LocalizedStringKey
    var token: String
    var isEditable = false
}

extension RemotePushInformationItem: RawRepresentable {
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "|")
        
        guard components.count == 3 else { return nil }
        title = LocalizedStringKey(components[0])
        token = components[1]
        isEditable = components[2] == "true"
    }
    
    var rawValue: String {
        "\(title)|\(token)|\(isEditable)"
    }
}

extension RemotePushInformationItem: Identifiable {
    
    var id: String {
        token
    }
}

extension RemotePushInformationItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension RemotePushInformationItem: Equatable {
    
    static func ==(lhs: RemotePushInformationItem, rhs: RemotePushInformationItem) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension RemotePushInformationItem {
    
    static var placeholder: RemotePushInformationItem {
        RemotePushInformationItem(title: "deviceToken",
                                  token: "ewogICJhY2Nlc3NfdG9rZW4iOiAieWEyOS5hMEFmQl9ieURvWnJpQVlKYUpHZGZZQlNySkIxMDFGWE80NG9jVDhLVUNpS3NLWjE0NWxrNGR6a0JPQVg0YkQzUXFubk9lSVphbFRPZGMwSUQyRkkyMXM4Uzlack92aFZGQ2ZZMFgxYThqcmNhZGYzM3V1U1UyY2lVWVRfX21tRVR3LUhDc2daaHZHQWFwRUFYdHFuTXBoSEJaZVpCS2xGRWh4UnpqYUNnWUtBVUFTQVJJU0ZRSEdYMk1pR3RxN2JsWG01VW15QmNWUU1IV2p4dzAxNzEiLCAKICAic2NvcGUiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vYXV0aC9jbG91ZC1wbGF0Zm9ybSIsIAogICJ0b2tlbl90eXBlIjogIkJlYXJlciIsIAogICJleHBpcmVzX2luIjogMzU5OSwgCiAgInJlZnJlc2hfdG9rZW4iOiAiMS8vMDRTa0RCOUZZSlVqR0NnWUlBUkFBR0FRU053Ri1MOUlyUnBEUG5hNVdpU3RxdDB4VXNRM1UtUlRhSEJXNm15dlZYeDAxOVRKdWZJTGdvWkVpaU1VeTNJTlktTUVNdGR3d3VxayIKfQ==")
    }
}
#endif
