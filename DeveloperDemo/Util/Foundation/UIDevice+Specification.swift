//
//  UIDevice+Specification.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

extension UIDevice {
    /**
     https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
     */
    enum Specification {
        case iPhoneSE
        case iPhoneXR

        var points: CGSize {
            switch self {
            case .iPhoneSE:
                return CGSize(width: 320.0, height: 568.0)
            case .iPhoneXR:
                return CGSize(width: 414.0, height: 896.0)
            }
        }

        var renderedPixels: CGSize {
            switch self {
            case .iPhoneSE:
                return CGSize(width: 640.0, height: 1136.0)
            case .iPhoneXR:
                return CGSize(width: 828.0, height: 1792.0)
            }
        }
    }
}
