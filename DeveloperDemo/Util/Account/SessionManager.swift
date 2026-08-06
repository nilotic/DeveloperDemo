//
//  SessionManager.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

@MainActor
final class SessionManager {

    static let shared = SessionManager()

    private init() {}

    /// JSON 웹 토큰 화면에서 토큰을 직접 갈아 끼울 때 호출합니다.
    /// 토큰 직접 주입은 더 이상 지원하지 않으므로 항상 실패합니다.
    func update(token: JSONWebToken?) async throws {
        guard token != nil else { throw ServiceError(message: "유효하지 않은 Token 입니다") }
        throw ServiceError(message: "JSONWebToken은 더 이상 지원되지 않습니다. update(accessToken:refreshToken:) 메서드를 사용하세요.")
    }

    /// 호스트를 바꾼 뒤 세션을 초기화합니다.
    func restartApp() async {
        await logout()
    }

    func update(accessToken: String?, refreshToken: String?) async {
        await TokenManager.shared.updateTokens(accessToken: accessToken, refreshToken: refreshToken)
    }

    func logout() async {
        await TokenManager.shared.clearTokens()
    }

    func requestRefreshToken() async throws -> (String, String) {
        throw ServiceError(message: "토큰 갱신은 지원하지 않습니다.")
    }
}
