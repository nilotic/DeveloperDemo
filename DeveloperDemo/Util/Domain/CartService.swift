//
//  CartService.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct CartService {

    // MARK: - Initializer
    init() {}


    // MARK: - Function
    // MARK: Public
    /// 호스트를 바꾸면 이전 서버에서 담은 장바구니를 비운다.
    @CartActor
    func clear() {}
}
