//
//  DeepLink.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

struct DeepLink {

    let url: URL

    init?(_ url: URL?) {
        guard let url else { return nil }
        self.url = url
    }

    /// 시스템에 URL 을 넘겨 딥링크 동작을 확인합니다.
    @MainActor
    func go() {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
