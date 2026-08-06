//
//  TypographysData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class TypographysData {
    
    // MARK: - Value
    // MARK: Public
    var sections = [TypographySection]()
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        sections = [.bold, .semibold, .regular]
    }
}
