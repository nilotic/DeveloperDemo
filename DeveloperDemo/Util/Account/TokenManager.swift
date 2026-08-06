//
//  TokenManager.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation
import Combine

actor TokenManager {
    
    // MARK: - Singleton
    static let shared = TokenManager()
    
    // MARK: - Private Properties
    private var _accessToken: String?
    private var _refreshToken: String?
    private var _jsonWebToken: JSONWebToken?
    
    // MARK: - Public Properties
    private(set) var hasValidTokens: Bool = false
    
    // MARK: - Private Dependencies
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - Constants
    private enum Key {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let jsonWebToken = "token"
    }
    
    // MARK: - Initialization
    private init() {
        Task { @MainActor in
            await initialize()
        }
    }
    
    private func initialize() async {
        setupDecoder()
        loadTokensFromStorage()
    }
    
    // MARK: - Private Setup
    private func setupDecoder() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: - Token Management
    
    var accessToken: String? {
        _accessToken
    }
    
    var refreshToken: String? {
        _refreshToken
    }
    
    var jsonWebToken: JSONWebToken? {
        _jsonWebToken
    }
    
    /// Access Token을 업데이트합니다.
    /// - Parameter token: 새로운 Access Token
    func updateAccessToken(_ token: String?) async {
        _accessToken = token
        saveTokensToStorage()
        updateTokenValidity()
    }
    
    /// Refresh Token을 업데이트합니다.
    /// - Parameter token: 새로운 Refresh Token
    func updateRefreshToken(_ token: String?) async {
        _refreshToken = token
        saveTokensToStorage()
        updateTokenValidity()
    }
    
    /// Access Token과 Refresh Token을 동시에 업데이트합니다.
    /// - Parameters:
    ///   - accessToken: 새로운 Access Token
    ///   - refreshToken: 새로운 Refresh Token
    func updateTokens(accessToken: String?, refreshToken: String?) async {
        _accessToken = accessToken
        _refreshToken = refreshToken
        saveTokensToStorage()
        updateTokenValidity()
    }
    
    /// 모든 토큰을 제거합니다.
    func clearTokens() async {
        _accessToken = nil
        _refreshToken = nil
        _jsonWebToken = nil
        clearTokensFromStorage()
        updateTokenValidity()
    }
    
    /// 테스트용 토큰 초기화 메서드
    /// - Note: 테스트 환경에서만 사용하세요
    func resetForTesting() async {
        _accessToken = nil
        _refreshToken = nil
        _jsonWebToken = nil
        clearTokensFromStorage()
        updateTokenValidity()
    }
    
    /// 토큰이 유효한지 확인합니다.
    /// - Returns: Access Token과 Refresh Token이 모두 존재하면 true
    func hasTokens() -> Bool {
        accessToken != nil && refreshToken != nil
    }
    
    func hasJsonWebToken() -> Bool {
        !hasTokens() && jsonWebToken != nil
    }
    
    // MARK: - Private Methods
    
    private func loadTokensFromStorage() {
        if let accessTokenData = userDefaults.data(forKey: Key.accessToken),
           let refreshTokenData = userDefaults.data(forKey: Key.refreshToken) {
            _accessToken = try? decoder.decode(String.self, from: accessTokenData)
            _refreshToken = try? decoder.decode(String.self, from: refreshTokenData)
        } else if let data = userDefaults.data(forKey: Key.jsonWebToken) {
            _jsonWebToken = try? decoder.decode(JSONWebToken.self, from: data)
        }
        
        updateTokenValidity()
    }
    
    private func saveTokensToStorage() {
        if let accessToken = accessToken,
           let encodedAccessToken = try? encoder.encode(accessToken) {
            userDefaults.set(encodedAccessToken, forKey: Key.accessToken)
        } else {
            userDefaults.removeObject(forKey: Key.accessToken)
        }
        
        if let refreshToken = refreshToken,
           let encodedRefreshToken = try? encoder.encode(refreshToken) {
            userDefaults.set(encodedRefreshToken, forKey: Key.refreshToken)
        } else {
            userDefaults.removeObject(forKey: Key.refreshToken)
        }
    }
    
    private func clearTokensFromStorage() {
        userDefaults.removeObject(forKey: Key.accessToken)
        userDefaults.removeObject(forKey: Key.refreshToken)
        userDefaults.removeObject(forKey: Key.jsonWebToken)
    }
    
    private func updateTokenValidity() {
        hasValidTokens = hasTokens()
    }
}

// MARK: - TokenManager Extensions

extension TokenManager: @preconcurrency CustomDebugStringConvertible {
    
    var debugDescription: String {
        """
        TokenManager Debug Info:
        - Access Token: \(accessToken?.prefix(10) ?? "nil")...
        - Refresh Token: \(refreshToken?.prefix(10) ?? "nil")...
        - Has Valid Tokens: \(hasValidTokens)
        """
    }
    
    /// 토큰이 변경되었는지 확인합니다.
    /// - Parameters:
    ///   - newAccessToken: 새로운 Access Token
    ///   - newRefreshToken: 새로운 Refresh Token
    /// - Returns: 토큰이 변경되었으면 true
    func tokensChanged(accessToken: String?, refreshToken: String?) async -> Bool {
        self.accessToken != accessToken || self.refreshToken != refreshToken
    }
} 
