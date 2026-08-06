//
//  HapticService.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

enum HapticService {
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    case impactIntensity(UIImpactFeedbackGenerator.FeedbackStyle, CGFloat)
    case notification(UINotificationFeedbackGenerator.FeedbackType)
    case selection
    
    // trigger
    public func generate() {
        switch self {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        case .impactIntensity(let style, let intensity):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred(intensity: intensity)
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}
