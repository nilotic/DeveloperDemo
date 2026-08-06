//
//  JSONWebTokenData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class JSONWebTokenData {

    // MARK: - Value
    // MARK: Public
    var text = "" {
        didSet { update() }
    }
    
    var components = [JSONWebTokenComponent]()
    var toastMessage = ""
    
    private(set) var token: JSONWebToken?
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        Task {
            text = await TokenManager.shared.accessToken ?? ""
        }
    }
    
    func clearToken() {
        text = ""
    }
    
    func copyToken() {
        UIPasteboard.general.string = text
        toastMessage = String(localizedFormat: "copiedPasteBoard", "Token")
    }
    
    func updateToken() {
        Task {
            do {
                try await SessionManager.shared.update(token: token)
                toastMessage = String(localized: "tokenUpdated")
            
            } catch {
                toastMessage = error.localizedDescription
            }
        }
    }
    
    func copy(component: JSONWebTokenComponent) {
        UIPasteboard.general.string = component.description
        toastMessage = String(localizedFormat: "copiedPasteBoard", component.title)
    }
    
    // MARK: Private
    private func update() {
        let token = JSONWebToken(rawValue: text)
        
        guard self.token != token else { return }
        withAnimation(.spring(response: 0.28, dampingFraction: 0.8)) {
            self.token = token
        
            guard let token else {
                components = []
                return
            }
            
            components = [JSONWebTokenComponent.header(token.header),
                          JSONWebTokenComponent.payload(token.payload),
                          JSONWebTokenComponent.signature(token.signature)]
        }
    }
}
