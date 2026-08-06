//
//  GooglePlaygroundOAuthRepresentable.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import WebKit

struct GooglePlaygroundOAuthViewRepresentable {
    
    // MARK: - Value
    // MARK: Public
    let scope: GooglePlaygroundOAuthScope
    var completion: ((FirebaseToken) -> Void)?
    
    // MARK: Private
    private var url: URL? {
        guard var components = URLComponents(url: ServiceURL.googlePlayground.rawValue, resolvingAgainstBaseURL: false) else { return nil}
        components.queryItems = [URLQueryItem(name: "redirect_uri", value: "https://\(Host.googleDeveloper.rawValue)/oauthplayground"),
                                 URLQueryItem(name: "prompt", value: "consent"),
                                 URLQueryItem(name: "response_type", value: "code"),
                                 URLQueryItem(name: "client_id", value: "407408718192.apps.googleusercontent.com"),
                                 URLQueryItem(name: "scope", value: scope.rawValue),
                                 URLQueryItem(name: "access_type", value: "offline")]
        
        return components.url
    }
}

extension GooglePlaygroundOAuthViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        
        if let url {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> GooglePlaygroundOAuthViewCoordinator {
        GooglePlaygroundOAuthViewCoordinator(scope: scope, completion: completion)
    }
}
