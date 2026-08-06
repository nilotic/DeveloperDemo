//
//  ServiceError.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ServiceError: Error {
    var code = ""
    let message: String
}

extension ServiceError: LocalizedError {

    var errorDescription: String? {
        description
    }
}

extension ServiceError: CustomStringConvertible {

    var description: String {
        message
    }
}

extension ServiceError: Decodable {

    private enum Key: String, CodingKey {
        case code
        case errorCode
        case message
        case error
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        
        // Message
        var userErrorMessage: String? {
            guard let data = try? container.decode([String: Any].self, forKey: .data), let errors = data["errors"] as? [[String: Any]],
                  let message = (errors.first?["messages"] as? [String])?.first, !message.isEmpty else { return nil }
            return message
        }
        
        var message: String? {
            guard let message = try? container.decode(String.self, forKey: .message), !message.isEmpty else { return nil }
            return message
        }
        
        self.message = userErrorMessage ?? message ?? String(localized: "networkError")
        
        
        // Code
        var code: String? {
            if let code = try? container.decode(Int.self, forKey: .code) {
                return "\(code)"
            }
            
            if let code = try? container.decode(String.self, forKey: .code) {
                return "\(code)"
            }
            
            return nil
            
        }
        
        var errorCode: String? {
            guard let error = try? container.decode([String: Any].self, forKey: .error) else { return nil }
           
            if let code = error["code"] as? String {
                return code
            }
            
            if let code = error["code"] as? Int {
                return "\(code)"
            }
          
            return nil
        }
        
        var topLevelErrorCode: String? {
            try? container.decode(String.self, forKey: .errorCode)
        }

        var dataErrorCode: String? {
            guard let data = try? container.decode([String: Any].self, forKey: .data), let error = data["error"] as? [String: Any] else { return nil }
            return error["code"] as? String
        }

        self.code = topLevelErrorCode ?? code ?? errorCode ?? dataErrorCode ?? ""
    }
}
