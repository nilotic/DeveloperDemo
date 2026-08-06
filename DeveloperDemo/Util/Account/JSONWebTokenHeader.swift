//
//  JSONWebTokenHeader.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct JSONWebTokenHeader {
    let keyID: String       // Apple Credential
    let algorithm: String
    let type: String
}

extension JSONWebTokenHeader: RawRepresentable {
    
    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8), let header = try? JSONDecoder().decode(JSONWebTokenHeader.self, from: data) else { return nil }
        self = header
    }
    
    var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        
        guard let data = try? encoder.encode(self), let string = String(data: data, encoding: .utf8) else { return "" }
        return string
    }
}

extension JSONWebTokenHeader: CustomStringConvertible {
    
    var description: String {
        rawValue
    }
}

extension JSONWebTokenHeader: Codable {
    
    private enum Key: String, CodingKey {
        case keyID = "kid"
        case algorithm = "alg"
        case type = "typ"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        
        do { try container.encode(keyID, forKey: .keyID) } catch { throw error }
        do { try container.encode(type, forKey: .type) } catch { throw error }
        do { try container.encode(algorithm, forKey: .algorithm) } catch { throw error }
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
    
        do { keyID = try container.decode(String.self, forKey: .keyID) } catch { keyID = "" }
        do { algorithm = try container.decode(String.self, forKey: .algorithm) } catch { throw error }
        do { type = try container.decode(String.self, forKey: .type) } catch { type = "" }
    }
}
