//
//  AppVersion.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct AppVersion {
    let major: Int
    let minor: Int
    let patch: Int
    let build: Int
}

extension AppVersion {
    
    var shortVersion: String {
        #if DEBUG
            "\(major < 100 ? major * 100 : major).\(minor).\(patch) (\(build))"
        #else
            "\(major < 100 ? major * 100 : major).\(minor).\(patch)"
        #endif
    }
}

extension AppVersion {
    
    init?(dictionary: [String : Any]?) {
        guard let dictionary, let shortVersionString = dictionary["CFBundleShortVersionString"] as? String else { return nil }
        
        // Normalize major: 300.18.0 → 3.18.0, 120.2.3 → 1.2.3
        let components = shortVersionString.components(separatedBy: ".")

        guard components.count == 3, let major = Int(components[0]), let minor = Int(components[1]), let patch = Int(components[2]) else { return nil }
        self.major = 100 <= major ? major / 100 : major
        self.minor = minor
        self.patch = patch
        self.build = Int(dictionary["CFBundleVersion"] as? String ?? "") ?? 0
    }
}

extension AppVersion: RawRepresentable {
    
    /// Formats: "3.67.0" or "3.67.0 (100)".
    init?(rawValue: String) {
        let string = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let regex = try? NSRegularExpression(pattern:  #"^\s*(\d+)\.(\d+)\.(\d+)(?:\s*\((\d+)\))?\s*$"#) else { return nil }
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        
        guard let match = regex.firstMatch(in: string, range: range) else { return nil }
        let substring = { (index: Int) -> Substring in
            let ranges = match.range(at: index)
            
            guard ranges.location != NSNotFound, let range = Range(ranges, in: string) else { return "" }
            return string[range]
        }
        
        guard let major = Int(substring(1)), let minor = Int(substring(2)), let patch = Int(substring(3)) else { return nil }
        self.major = major
        self.minor = minor
        self.patch = patch
        self.build = Int(substring(4)) ?? 0
    }
    
    var rawValue: String {
        #if DEBUG
            "\(major).\(minor).\(patch) (\(build))"
        #else
            "\(major).\(minor).\(patch)"
        #endif
    }
}

extension AppVersion: CustomStringConvertible {
    
    var description: String {
        rawValue
    }
}
    
extension AppVersion: CustomDebugStringConvertible {
    
    var debugDescription: String {
        description
    }
}

extension AppVersion: Identifiable {
    
    var id: String {
        "\(major).\(minor).\(patch)"
    }
}

extension AppVersion: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension AppVersion: Equatable {
    
    static func == (lhs: AppVersion, rhs: AppVersion) -> Bool {
        (lhs.major, lhs.minor, lhs.patch) == (rhs.major, rhs.minor, rhs.patch)
    }
}

extension AppVersion: Comparable {
    
    static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
        (lhs.major, lhs.minor, lhs.patch) < (rhs.major, rhs.minor, rhs.patch)
    }
}

extension AppVersion: Codable {
    
    private enum Key: String, CodingKey {
        case version
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(rawValue, forKey: .version)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
         
        guard let appVersion = AppVersion(rawValue: try container.decode(String.self, forKey: .version)) else {
            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid version format"))
        }
        
        self = appVersion
    }
}
