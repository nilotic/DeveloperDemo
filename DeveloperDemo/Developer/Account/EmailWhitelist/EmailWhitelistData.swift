//
//  EmailWhitelistData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine
import AuthenticationServices

@MainActor
@Observable
final class EmailWhitelistData {
    
    // MARK: - Value
    // MARK: Public
    var email = ""
    var phoneNumber = ""
    var teamName = ""
    var toastMessage = ""
    
    private(set) var isProgressing = false
    
    private(set) var alertMessage = ""
    
    // MARK: Private
    @ObservationIgnored
    private var task: Task<Void, Never>? = nil
    
    
    // MARK: - Function
    // MARK: Public
    func register() {
        task?.cancel()
        task = Task {
            isProgressing = true
            
            do {
                try validate()
                try await requestRegister(email: email, phoneNumber: phoneNumber, teamName: teamName)
                
                toastMessage = String(localizedFormat: "registeredEmail", email, phoneNumber, teamName)
                reset()
            
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }
    
    func handle(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let identityToken = (authorization.credential as? ASAuthorizationAppleIDCredential)?.identityToken, let email = try? JSONWebToken(data: identityToken).payload.email else {
                toastMessage = String(localized: "appleAccountEmailFailure")
                return
            }
            
            self.email = email
            
        case .failure(let error):
            toastMessage = error.localizedDescription
        }
    }
    
    // MARK: Private
    private func validate() throws {
        // Email
        guard !email.isEmpty else { throw ServiceError(message: String(localized: "emailPlaceholder")) }
        
        // PhoneNumber
        guard !phoneNumber.isEmpty else { throw ServiceError(message: String(localized: "phoneNumberTextFieldPlaceholder")) }
        guard Validator.validate(phoneNumber: phoneNumber.replacingOccurrences(of: "-", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) else {
            throw ServiceError(message: String(localized: "invalidPhoneNumberAlertTitle"))
        }
        
        // TeamName
        guard !teamName.isEmpty else { throw ServiceError(message: String(localized: "teamNameTextFieldPlaceholder")) }
    }
    
    private func reset() {
        email = ""
        phoneNumber = ""
        teamName = ""
    }
    
    private func requestRegister(email: String, phoneNumber: String, teamName: String) async throws {
        var request = await URLRequest(httpMethod: .post, url: .registerWhitelist)
        request.set(value: .application(.json), field: .contentType)
        request.set(value: .application(.json), field: .accept)
        
        let requestData = EmailWhitelistRegisterRequest(email: email, phoneNumber: phoneNumber, teamName: teamName)
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)
        
        guard response.statusCode == .ok else { throw response.error ?? URLError(.badServerResponse) }
    }
}
