//
//  HTTPHeaderValue.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum HTTPHeaderValue {
    case application(ApplicationMediaSet)
    case multipart(MultipartType)
    case authorization(HTTPAuthorization)
    
    @available(*, deprecated, renamed: "application")
    case applicationJSON
    
    @available(*, deprecated, renamed: "application")
    case applicationJsonUTF8
}

extension HTTPHeaderValue {

    var rawValue: String {
        switch self {
        case .application(let set):                 "application/\(set.description)"
        case .multipart(let multipart):             "multipart/\(multipart.rawValue)"
        case .authorization(let authorization):     authorization.rawValue
        case .applicationJSON:                      "application/json"
        case .applicationJsonUTF8:                  "application/json;charset=utf-8"
        }
    }
}
