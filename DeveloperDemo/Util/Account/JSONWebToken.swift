//
//  JSONWebToken.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct JSONWebToken {
    let header: JSONWebTokenHeader
    let payload: JSONWebTokenPayload
    let signature: String
    let rawValue: String
}

extension JSONWebToken {

    var uuidString: String? {
        payload.uuid?.uuidString.lowercased()
    }
}

extension JSONWebToken: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension JSONWebToken: Equatable {

    static func == (lhs: JSONWebToken, rhs: JSONWebToken) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension JSONWebToken: RawRepresentable {

    init(data: Data?) throws {
        guard let data, let string = String(data: data, encoding: .utf8), let token = JSONWebToken(rawValue: string) else {
            throw URLError(.badServerResponse)
        }

        self = token
    }

    init?(rawValue: String?) {
        guard let rawValue else { return nil }
        self.init(rawValue: rawValue)
    }

    init?(rawValue: String) {
        self.rawValue = rawValue

        let encodedData = { (string: String) -> Data? in
            var encodedString = string.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")

            switch (encodedString.utf16.count % 4) {
            case 2:     encodedString = "\(encodedString)=="
            case 3:     encodedString = "\(encodedString)="
            default:    break
            }

            return Data(base64Encoded: encodedString)
        }

        let components = rawValue.components(separatedBy: ".")

        guard components.count == 3, let headerData = encodedData(components[0]), let payloadData = encodedData(components[1]) else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            header = try decoder.decode(JSONWebTokenHeader.self, from: headerData)
            payload = try decoder.decode(JSONWebTokenPayload.self, from: payloadData)
            signature = components[2] as String

        } catch {
            return nil
        }
    }
}

extension JSONWebToken: Codable {

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        do { try container.encode(rawValue) } catch { throw error }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let token = JSONWebToken(rawValue: try container.decode(String.self)) else {
            throw URLError(.badServerResponse)
        }

        self = token
    }
}
