//
//  MultipartType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum MultipartType {
    case none
    case alternative
    case byteranges
    case digest
    case formData(String)
    case mixed
    case parallel
    case related(String)
    case report
    case signed
    case encrypted
}

extension MultipartType {

    var rawValue: String {
        switch self {
        case .none:                     ""
        case .alternative:              "alternative"
        case .byteranges:               "byteranges"
        case .digest:                   "digest"
        case .formData(let boundary):   "form-data\(boundary != "" ? ";boundary=\(boundary)" : "")"
        case .mixed:                    "mixed"
        case .parallel:                 "parallel"
        case .related(let boundary):    "related\(boundary != "" ? ";boundary=\(boundary)" : "")"
        case .report:                   "report"
        case .signed:                   "signed"
        case .encrypted:                "encrypted"
        }
    }
}
