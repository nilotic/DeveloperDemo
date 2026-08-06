//
//  VersionManager.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

final class VersionManager: Sendable {

    // MARK: - Singleton
    static let shared = VersionManager()


    // MARK: - Value
    // MARK: Public
    var shortVersionString: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0.0.0"
    }

    var versionString: String {
        "\(shortVersionString) (\(buildString))"
    }

    // MARK: Private
    private var buildString: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
    }


    // MARK: - Initializer
    private init() {}
}
