//
//  ColorPickerWebViewRepresentable.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import WebKit

struct ColorPickerWebViewRepresentable {
    
    // MARK: - Value
    // MARK: Public
    let htmlString: String
    var completion: (() -> Void)?
}

extension ColorPickerWebViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator
        webView.loadHTMLString(htmlString, baseURL: nil)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> ColorPickerWebCoordinator {
        ColorPickerWebCoordinator(completion: completion)
    }
}
