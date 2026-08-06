//
//  AppIconsData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class AppIconsData {
    
    // MARK: - Value
    // MARK: Public
    var icons = SeasonalEventAppIconType.allCases
    var toastMessage = ""
    
    
    // MARK: - Function
    // MARK: Public
    func handle(type: SeasonalEventAppIconType) {
        Task {
            do {
                try await UIApplication.shared.setAlternateIconName(type.iconName)
                
            } catch {
                toastMessage = error.localizedDescription
            }
        }
    }
}
