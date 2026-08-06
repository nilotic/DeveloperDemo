//
//  NetworkActor.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

@globalActor
struct NetworkActor {
  actor ActorType { }

  static let shared = ActorType()
}

extension NetworkActor {
    
    @discardableResult
    static func run<T: Sendable>(body: @NetworkActor @Sendable () throws -> T) async rethrows -> T {
        try await body()
    }
}

