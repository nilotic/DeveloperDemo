//
//  AmplitudeEvent.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

/// 이 데모는 계측을 전송하지 않는다. 호출부를 그대로 두기 위한 최소 정의다.
struct AmplitudeEvent {

    // MARK: - Function
    // MARK: Public
    static func name(_ name: AmplitudeEventName) -> AmplitudeEvent? {
        AmplitudeEvent()
    }

    func properties(_ properties: AmplitudeEventProperties?) -> AmplitudeEvent {
        self
    }

    func send() {}
}
