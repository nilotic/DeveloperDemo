//
//  Extensions.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

extension String {

    init(localizedFormat: String, _ arguments: CVarArg...) {
        self = String(format: String(localized: LocalizationValue(localizedFormat)), arguments: arguments)
    }
}

// MARK: - [String: Any] 디코딩

private struct AnyCodingKey: CodingKey {

    let stringValue: String
    let intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

extension KeyedDecodingContainer {

    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        try nestedContainer(keyedBy: AnyCodingKey.self, forKey: key).decodeDictionary()
    }

    func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
        var container = try nestedUnkeyedContainer(forKey: key)
        return try container.decodeArray()
    }

    fileprivate func decodeDictionary() throws -> [String: Any] {
        var dictionary = [String: Any]()

        for key in allKeys {
            if let value = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = value

            } else if let value = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = value

            } else if let value = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = value

            } else if let value = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = value

            } else if let value = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = value

            } else if let value = try? decode([Any].self, forKey: key) {
                dictionary[key.stringValue] = value
            }
        }

        return dictionary
    }
}

private extension UnkeyedDecodingContainer {

    mutating func decodeArray() throws -> [Any] {
        var array = [Any]()

        while !isAtEnd {
            if let value = try? decode(Bool.self) {
                array.append(value)

            } else if let value = try? decode(Int.self) {
                array.append(value)

            } else if let value = try? decode(Double.self) {
                array.append(value)

            } else if let value = try? decode(String.self) {
                array.append(value)

            } else if let container = try? nestedContainer(keyedBy: AnyCodingKey.self) {
                array.append(try container.decodeDictionary())

            } else if var container = try? nestedUnkeyedContainer() {
                array.append(try container.decodeArray())

            } else {
                _ = try? decodeNil()
            }
        }

        return array
    }
}

// MARK: - UserDefaults

extension UserDefaults {

    private enum DeveloperKey: String {
        case pushDeviceToken
        case firebaseToken

        var defaultName: String {
            "DeveloperDemo.Defaults.\(rawValue)"
        }
    }

    var pushDeviceToken: Data? {
        get { UserDefaults.standard.data(forKey: DeveloperKey.pushDeviceToken.defaultName) }
        set { UserDefaults.standard.set(newValue, forKey: DeveloperKey.pushDeviceToken.defaultName) }
    }

    var firebaseToken: String? {
        get { UserDefaults.standard.string(forKey: DeveloperKey.firebaseToken.defaultName) }
        set { UserDefaults.standard.set(newValue, forKey: DeveloperKey.firebaseToken.defaultName) }
    }
}

extension Error {

    var code: Int {
        if let codeString = (self as? ServiceError)?.code, let code = Int(codeString) {
            return code

        } else {
            return (self as NSError).code
        }
    }
}
