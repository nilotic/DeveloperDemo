//
//  ColorPickerWebCoordinator.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import WebKit

final class ColorPickerWebCoordinator: NSObject {
    
    // MARK: - Value
    // MARK: Private
    private let completion: (() -> Void)?
    
    
    // MARK: - Initializer
    init(completion: (() -> Void)?) {
        self.completion = completion
    }
}

// MARK: - WKNavigation Delegate
extension ColorPickerWebCoordinator: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        completion?()
    }
}
