//
//  ServiceURL.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum ServiceURL {

    // 계정 (백오피스)
    case searchAccounts
    case searchWithdrawalAccounts
    case withdrawAccount(Int)
    case deleteWithdrawalAccount
    case updateLockStatus(Int)

    // 이메일 화이트리스트
    case registerWhitelist

    // 호스트 헬스체크
    case memberHealth

    // 푸시 / OAuth
    case googleOAuthPlayground
    case googlePlayground
    case sendMessage

    // 게스트 토큰 (NetworkManager 401 처리 경로)
    case guestToken
}

extension ServiceURL: RawRepresentable {

    typealias RawValue = URL

    var rawValue: URL {
        switch self {
        case .searchAccounts:
            URL(string: "https://\(hosts.backOffice.rawValue)/v1/admin/accounts")!

        case .searchWithdrawalAccounts:
            URL(string: "https://\(hosts.backOffice.rawValue)/v1/admin/withdrawn-accounts")!

        case let .withdrawAccount(userNumber):
            URL(string: "https://\(hosts.backOffice.rawValue)/v1/admin/accounts/\(userNumber)/withdraw")!

        case .deleteWithdrawalAccount:
            URL(string: "https://\(hosts.backOffice.rawValue)/v1/admin/withdrawn-accounts/release")!

        case let .updateLockStatus(userNumber):
            URL(string: "https://\(hosts.backOffice.rawValue)/v1/admin/accounts/\(userNumber)/login-status")!

        case .registerWhitelist:
            URL(string: "https://\(hosts.commerce.rawValue)/api/v1/whitelist")!

        case .memberHealth:
            URL(string: "https://gateway.stg.example.net/actuator/health")!

        case .googleOAuthPlayground:
            URL(string: "https://\(Host.googleDeveloper.rawValue)/oauthplayground/exchangeAuthCode")!

        case .googlePlayground:
            URL(string: "https://\(Host.googleAccount.rawValue)/o/oauth2/v2/auth")!

        case .sendMessage:
            URL(string: "https://\(Host.firebaseCloudMessaging.rawValue)/v1/projects/demo-project/messages:send")!

        case .guestToken:
            URL(string: "https://\(hosts.authentication.rawValue)/guest")!
        }
    }

    init?(rawValue: URL) {
        switch rawValue.absoluteString {
        case Self.googlePlayground.rawValue.absoluteString:     self = .googlePlayground
        default:                                                return nil
        }
    }
}
