//
//  SeasonalEventAppIconType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum SeasonalEventAppIconType: String, CaseIterable {
    case none
    case service
    case anniversary24
    case anniversary25
    case newYear24
    case newYear25
    case newYear26
    case christmas23
    case christmas24
    case christmas25
    case koreanThanksgiving25
}

extension SeasonalEventAppIconType {
    
    /// Specify nil if you want to display the app’s primary icon, which you declare using the CFBundlePrimaryIcon key.
    var iconName: String? {
        switch self {
        case .none:                 nil
        case .service:                "Demo\(scheme)AppIcon"
        case .anniversary24:        "Anniversary24\(scheme)AppIcon"
        case .anniversary25:        "Anniversary25\(scheme)AppIcon"
        case .newYear24:            "NewYear24\(scheme)AppIcon"
        case .newYear25:            "NewYear25\(scheme)AppIcon"
        case .newYear26:            "NewYear26\(scheme)AppIcon"
        case .christmas23:          "Christmas23\(scheme)AppIcon"
        case .christmas24:          "Christmas24\(scheme)AppIcon"
        case .christmas25:          "Christmas25\(scheme)AppIcon"
        case .koreanThanksgiving25: "KoreanThanksgiving25\(scheme)AppIcon"
        }
    }
    
    var thumbnailName: String {
        switch self {
        case .none:                 "\(scheme)AppIcon60x60"
        case .service:                "Demo\(scheme)Thumbnail"
        case .anniversary24:        "Anniversary24\(scheme)Thumbnail"
        case .anniversary25:        "Anniversary25\(scheme)Thumbnail"
        case .newYear24:            "NewYear24\(scheme)Thumbnail"
        case .newYear25:            "NewYear25\(scheme)Thumbnail"
        case .newYear26:            "NewYear26\(scheme)Thumbnail"
        case .christmas23:          "Christmas23\(scheme)Thumbnail"
        case .christmas24:          "Christmas24\(scheme)Thumbnail"
        case .christmas25:          "Christmas25\(scheme)Thumbnail"
        case .koreanThanksgiving25: "KoreanThanksgiving25\(scheme)Thumbnail"
        }
    }
    
    private var scheme: String {
        #if BETA
        "Beta"
        #else
        ""
        #endif
    }
}

extension SeasonalEventAppIconType: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension SeasonalEventAppIconType: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension SeasonalEventAppIconType: Equatable {
    
    static func ==(lhs: SeasonalEventAppIconType, rhs: SeasonalEventAppIconType) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension SeasonalEventAppIconType: CustomStringConvertible {
   
    var description: String {
        switch self {
        case .none:                 String(localized: "default")
        case .service:                String(localized: "service")
        case .anniversary24:        String(localizedFormat: "anniversary", 9, 24)
        case .anniversary25:        String(localizedFormat: "anniversary", 10, 25)
        case .newYear24:            String(localizedFormat: "newYear", 24)
        case .newYear25:            String(localizedFormat: "newYear", 25)
        case .newYear26:            String(localizedFormat: "newYear", 26)
        case .christmas23:          String(localizedFormat: "christmas", 23)
        case .christmas24:          String(localizedFormat: "christmas", 24)
        case .christmas25:          String(localizedFormat: "christmas", 25)
        case .koreanThanksgiving25: String(localizedFormat: "koreanThanksgiving", 25)
        }
    }
}

extension SeasonalEventAppIconType: CustomDebugStringConvertible {
    
    var debugDescription: String {
        description
    }
}

extension SeasonalEventAppIconType: Codable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        do { try container.encode(rawValue) } catch { throw error }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            guard let type = SeasonalEventAppIconType(rawValue: try container.decode(RawValue.self)) else {
                throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to decode a SeasonalEventAppIconType."))
            }
            
            self = type
            
        } catch { throw error }
    }
}

#if DEBUG || BETA
extension SeasonalEventAppIconType {
    
    static var placeholder: SeasonalEventAppIconType {
        .service
    }
}

#endif

