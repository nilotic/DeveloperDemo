//
//  PushManager.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

final class PushManager: Sendable {

    // MARK: - Singleton
    static let shared = PushManager()


    // MARK: - Value
    // MARK: Public
    var pushDeviceID: String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }


    // MARK: - Initializer
    private init() {}
}
