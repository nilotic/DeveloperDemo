//
//  GooglePlaygroundOAuthScope.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum GooglePlaygroundOAuthScope {
    case remotePush
    case drive
}

extension GooglePlaygroundOAuthScope: RawRepresentable {
    
    init?(rawValue: String) {
        switch rawValue {
        case Self.remotePush.rawValue:   self = .remotePush
        case Self.drive.rawValue:        self = .drive
        default:                         return nil
        }
    }
    
    var queryValue: String {
        rawValue.replacingOccurrences(of: "+", with: " ")
    }
    
    var rawValue: String {
        switch self {
        case .remotePush:   
            "https://\(Host.googleAPI.rawValue)/auth/cloud-platform"
            
        case .drive:       
            "https://\(Host.googleAPI.rawValue)/auth/drive+https://www.googleapis.com/auth/drive.appdata+https://www.googleapis.com/auth/drive.file+https://www.googleapis.com/auth/drive.metadata+https://www.googleapis.com/auth/drive.metadata.readonly+https://www.googleapis.com/auth/drive.photos.readonly+https://www.googleapis.com/auth/drive.readonly+https://www.googleapis.com/auth/drive.scripts"
        }
    }
}
