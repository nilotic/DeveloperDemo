//
//  SocialType.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

enum SocialType: String, CaseIterable {
    case none
    case apple = "APPLE"
    case kakao = "KAKAO"
    case naver = "NAVER"
    
    var eventDescription: String? {
        switch self {
        case .none:     nil
        case .apple:    "APPLE"
        case .kakao:    "KAKAOSYNC"
        case .naver:    "NAVER"
        }
    }
}

extension SocialType {
    
    init(tag: Int) {
        switch tag {
        case SocialType.none.tag:     self = .none
        case SocialType.apple.tag:    self = .apple
        case SocialType.kakao.tag:    self = .kakao
        case SocialType.naver.tag:    self = .naver
        default:                      self = .none
        }
    }
}

extension SocialType {
    
    var title: String {
        switch self {
        case .none:     ""
        case .apple:    String(localized: "appleSignup")
        case .kakao:    String(localized: "kakaoSignup")
        case .naver:    String(localized: "naverSignup")
        }
    }
    
    var joinTitle: String {
        switch self {
        case .none:  ""
        case .naver: String(localized: "naverJoin")
        case .kakao: String(localized: "join")
        case .apple: String(localized: "phoneNumberAuthenticationJoin")
        }
    }
    
    var tag: Int {
        switch self {
        case .none:     0
        case .apple:    1
        case .kakao:    2
        case .naver:    3
        }
    }
    
    var path: String {
        switch self {
        case .none:     ""
        case .apple:    "apple"
        case .kakao:    "kakao"
        case .naver:    "naver"
        }
    }
    
    /// AppsFlyer 전용
    var loginMethod: String {
        switch self {
        case .none:     "service"
        case .apple:    "apple"
        case .kakao:    "kakao"
        case .naver:    "naver"
        }
    }
    
    var registrationMethod: String {
        switch self {
        case .none:     "service"
        case .apple:    "apple"
        case .kakao:    "kakaosync"
        case .naver:    "naver"
        }
    }
}

extension SocialType: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do { self = SocialType(rawValue: try container.decode(RawValue.self)) ?? .none } catch { self = .none }
    }
}
