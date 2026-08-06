//
//  HTTPMethod.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case patch  = "PATCH"
    case put    = "PUT"
    case post   = "POST"
    case delete = "DELETE"
}

extension HTTPMethod {

    init?(request: URLRequest?) {
        guard let string = request?.httpMethod, let method = HTTPMethod(rawValue: string) else { return nil }
        self = method
    }
}
