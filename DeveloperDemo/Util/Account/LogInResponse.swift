//
//  LogInResponse.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct LogInResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
