//
//  UIDevice+Extension.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import UIKit

extension UIDevice {
    var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)

        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }

            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }

    var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    var isMacCatalystApp: Bool {
        ProcessInfo.processInfo.isMacCatalystApp
    }

    var bottomSafeAreaInset: CGFloat {
        var bottomSafeAreaInset: CGFloat = 0.0
        hasSafeAreaInsets {
            bottomSafeAreaInset = $0.bottom
        }

        return bottomSafeAreaInset
    }

    @discardableResult
    func hasSafeAreaInsets(_ eventHandler: ((_ insets: UIEdgeInsets) -> Void)? = nil) -> Bool {
        if #available(iOS 11.0, *) {
            /**
             Home Indicator
             - 34.0 on iPhone X, XS, XS Max, XR
             - 20.0 on iPad Pro 12.9" 3rd generation
             */
            let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero

            eventHandler?(safeAreaInsets)

            return true
        } else {
            eventHandler?(.zero)

            return false
        }
    }
}
