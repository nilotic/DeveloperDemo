//
//  AmplitudeManager.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

final class AmplitudeManager: Sendable {

    // MARK: - Singleton
    static let shared = AmplitudeManager()


    // MARK: - Value
    // MARK: Public
    var deviceID: String {
        PushManager.shared.pushDeviceID
    }

    var userID: String {
        ""
    }


    // MARK: - Initializer
    private init() {}
}
