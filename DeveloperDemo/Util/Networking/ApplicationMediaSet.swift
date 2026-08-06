//
//  ApplicationMediaSet.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ApplicationMediaSet: OptionSet {
    let rawValue: Int
    
    static let json = ApplicationMediaSet(rawValue: 1 << 0)
    static let urlEncoded = ApplicationMediaSet(rawValue: 1 << 1)
    static let pdf = ApplicationMediaSet(rawValue: 1 << 2)
    static let zip = ApplicationMediaSet(rawValue: 1 << 3)
    static let octetStream = ApplicationMediaSet(rawValue: 1 << 4)
}

extension ApplicationMediaSet {
    
    init(value: String?) {
        var mediaSet = ApplicationMediaSet(rawValue: 0)
        
        guard let value else {
            self = mediaSet
            return
        }
        
        if value.contains("json")                   { mediaSet.insert(.json) }
        if value.contains("x-www-form-urlencoded")  { mediaSet.insert(.urlEncoded) }
        if value.contains("pdf")                    { mediaSet.insert(.pdf) }
        if value.contains("zip")                    { mediaSet.insert(.zip) }
        if value.contains("octet-stream")           { mediaSet.insert(.octetStream) }
     
        self = mediaSet
    }
}

extension ApplicationMediaSet {
    
    var types: String {
        var components = [String]()
        
        if contains(.json)        { components.append("json") }
        if contains(.urlEncoded)  { components.append("x-www-form-urlencoded") }
        if contains(.pdf)         { components.append("pdf") }
        if contains(.zip)         { components.append("zip") }
        if contains(.octetStream) { components.append("octet-stream") }
        
        return components.joined(separator: ";")
    }
}

extension ApplicationMediaSet: CustomStringConvertible {
    
    var description: String {
        types
    }
}

extension ApplicationMediaSet: CustomDebugStringConvertible {
    
    var debugDescription: String {
        types
    }
}

