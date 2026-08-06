//
//  SeasonalEventAppIcon.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct SeasonalEventAppIcon {
    let type: SeasonalEventAppIconType
}

extension SeasonalEventAppIcon: Identifiable {
    
    var id: String {
        rawValue
    }
}

extension SeasonalEventAppIcon: RawRepresentable {
    
    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else { return nil }
        do { self = try JSONDecoder().decode(Self.self, from: data) } catch { return nil }
    }
    
    var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        
        guard let data = try? encoder.encode(self), let string = String(data: data, encoding: .utf8) else { return "" }
        return string
    }
}

extension SeasonalEventAppIcon: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension SeasonalEventAppIcon: Equatable {
    
    static func == (lhs: SeasonalEventAppIcon, rhs: SeasonalEventAppIcon) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension SeasonalEventAppIcon: CustomStringConvertible {
   
    var description: String {
        rawValue
    }
}

extension SeasonalEventAppIcon: CustomDebugStringConvertible {
    
    var debugDescription: String {
        rawValue
    }
}

extension SeasonalEventAppIcon: Codable {
    
    private enum Key: String, CodingKey {
        case type
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(type, forKey: .type) } catch { throw error }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        do { type = try container.decode(SeasonalEventAppIconType.self, forKey: .type) } catch { throw error }
    }
}

extension SeasonalEventAppIcon {

    static var appIcon: SeasonalEventAppIcon {
        SeasonalEventAppIcon(type: .service)
    }

    static var newYearAppIcon: SeasonalEventAppIcon {
        SeasonalEventAppIcon(type: .newYear25)
    }

    static var christmasAppIcon: SeasonalEventAppIcon {
        SeasonalEventAppIcon(type: .christmas25)
    }

    static var placeholder: SeasonalEventAppIcon {
        SeasonalEventAppIcon(type: .christmas24)
    }
}

