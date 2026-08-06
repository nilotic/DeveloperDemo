//
//  DeveloperItem.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

enum DeveloperItem: String, CaseIterable {
    case hosts
    case signature
    case jsonWebToken
    case socialAccountInformation
    case lockAccount
    case deleteAccount
    case emailWhitelist
    case localPushes
    case remotePush
    case deeplink
    case colorPalette
    case colorPicker
    case typography
    case imageContentMode
    case haptic
    case seasonalEvent
    case appIcon
    case growthBook
}

extension DeveloperItem {
    
    var title: LocalizedStringKey {
        switch self {
        case .hosts:                        "hosts"
        case .signature:                    "signature"
        case .jsonWebToken:                 "jsonWebToken"
        case .socialAccountInformation:     "socialAccountInformation"
        case .lockAccount:                  "lockAccount"
        case .deleteAccount:                "deleteAccount"
        case .emailWhitelist:               "emailWhitelist"
        case .localPushes:                  "localPushes"
        case .remotePush:                   "remotePush"
        case .deeplink:                     "deeplink"
        case .colorPalette:                 "colorPalette"
        case .colorPicker:                  "colorPicker"
        case .typography:                   "typography"
        case .imageContentMode:             "imageContentMode"
        case .haptic:                       "haptic"
        case .seasonalEvent:                "seasonalEvent"
        case .appIcon:                      "appIcon"
        case .growthBook:                   "growthBook"
        }
    }
    
    var titleColor: Color {
        Color(.displayP3, red: 36 / 255, green: 36 / 255, blue: 36 / 255)
    }
    
    var imageName: String {
        switch self {
        case .hosts:                        "server.rack"
        case .signature:                    "signature"
        case .jsonWebToken:                 "key"
        case .socialAccountInformation:     "person"
        case .lockAccount:                  "lock"
        case .deleteAccount:                "person.2.slash"
        case .emailWhitelist:               "list.bullet.rectangle.portrait"
        case .localPushes:                  "envelope"
        case .remotePush:                   "paperplane"
        case .deeplink:                     "link"
        case .colorPalette:                 "swatchpalette"
        case .colorPicker:                  "eyedropper"
        case .typography:                   "textformat.size"
        case .imageContentMode:             "photo"
        case .haptic:                       "iphone.gen2.radiowaves.left.and.right"
        case .seasonalEvent:                "snowflake"
        case .appIcon:                      "app.dashed"
        case .growthBook:                   "lightbulb.circle.fill"
        }
    }
    
    var imageColor: Color {
        switch self {
        case .hosts:                        Color(.displayP3, red: 120 / 255, green: 197 / 255, blue: 241 / 255)
        case .signature:                    Color(.displayP3, red: 120 / 255, green: 197 / 255, blue: 241 / 255)
        case .jsonWebToken:                 Color(.displayP3, red: 106 / 255, green: 143 / 255, blue: 206 / 255)
        case .socialAccountInformation:     Color(.displayP3, red: 106 / 255, green: 143 / 255, blue: 206 / 255)
        case .lockAccount:                  Color(.displayP3, red: 106 / 255, green: 143 / 255, blue: 206 / 255)
        case .deleteAccount:                Color(.displayP3, red: 106 / 255, green: 143 / 255, blue: 206 / 255)
        case .emailWhitelist:               Color(.displayP3, red: 106 / 255, green: 143 / 255, blue: 206 / 255)
        case .localPushes:                  Color(.displayP3, red: 60 / 255,  green: 135 / 255, blue: 235 / 255)
        case .remotePush:                   Color(.displayP3, red: 60 / 255,  green: 135 / 255, blue: 235 / 255)
        case .deeplink:                     Color(.displayP3, red: 59 / 255,  green: 130 / 255, blue: 247 / 255)
        case .colorPalette:                 Color(.displayP3, red: 94 / 255,  green: 92 / 255,  blue: 222 / 255)
        case .colorPicker:                  Color(.displayP3, red: 94 / 255,  green: 92 / 255,  blue: 222 / 255)
        case .typography:                   Color(.displayP3, red: 94 / 255,  green: 92 / 255,  blue: 222 / 255)
        case .imageContentMode:             Color(.displayP3, red: 94 / 255,  green: 92 / 255,  blue: 222 / 255)
        case .haptic:                       Color(.displayP3, red: 94 / 255,  green: 92 / 255,  blue: 222 / 255)
        case .seasonalEvent:                Color(.displayP3, red: 151 / 255, green: 8 / 255,   blue: 237 / 255)
        case .appIcon:                      Color(.displayP3, red: 151 / 255, green: 8 / 255,   blue: 237 / 255)
        case .growthBook:                   Color(.displayP3, red: 120 / 255, green: 197 / 255, blue: 241 / 255)
        }
    }
}

extension DeveloperItem: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension DeveloperItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension DeveloperItem: Equatable {
    
    static func ==(lhs: DeveloperItem, rhs: DeveloperItem) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

#if DEBUG
extension DeveloperItem {
    
    static var placeholder: DeveloperItem {
        .hosts
    }
}
#endif
