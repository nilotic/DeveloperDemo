//
//  HTTPResponse.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct HTTPResponse {
    let url: URL
    let headerFields: [AnyHashable: Any]
    let data: Data?
    let statusCode: HTTPStatusCode
}

extension HTTPResponse {
    
    var experiment: GrowthBookExperiment? {
        GrowthBookExperiment(headerFields: headerFields)
    }
    
    var error: Error? {
        switch statusCode.rawValue {
        case 200..<300:
            return nil
        
        default:
            guard let data, let error = (try? JSONDecoder().decode(ServiceError.self, from: data)) else { return URLError(.badServerResponse) }
            return error
        }
    }
}

extension HTTPResponse {
    
    init(data: Data?, urlResponse: URLResponse?) throws {
        guard let urlResponse = urlResponse as? HTTPURLResponse, let url = urlResponse.url else { throw URLError(.badServerResponse) }
        
        self.url = url
        headerFields = urlResponse.allHeaderFields
        self.data = data
        
        statusCode = HTTPStatusCode(rawValue: urlResponse.statusCode) ?? .none
    }
}

extension HTTPResponse: CustomDebugStringConvertible {
    
    var debugDescription: String {
        var headerFieldsDescription: String {
            guard let headerFields = headerFields as? [String: String] else { return headerFields.debugDescription }
            return headerFields.debugDescription
        }
        
        return """
        Response
        HTTP status: \(statusCode.rawValue)
        URL: \(url.absoluteString)\n
        HeaderField
        \(headerFieldsDescription))\n
        Data
        \(String(data: data ?? Data(), encoding: .utf8) ?? "")
        \n
        """
    }
}
