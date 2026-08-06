//
//  DeleteAccountData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class DeleteAccountData {
    
    // MARK: - Value
    // MARK: Public
    var keyword = ""
    var searchType: DeletableAccountSearchType = .userID
    
    private(set) var deletableAccountItems = [DeletableAccountItem]()
    private(set) var withdrawalAccountItems = [WithdrawalAccountItem]()
    
    private(set) var isProgressing = false
    private(set) var searchedKeyword = ""
    
    var isPresented = false
    var toastMessage = ""
    
    var isEmpty: Bool {
        deletableAccountItems.isEmpty && withdrawalAccountItems.isEmpty
    }
    
    // MARK: Private
    @ObservationIgnored
    private var task: Task<Void, Never>? = nil
    
    
    // MARK: - Function
    // MARK: Public
    func search() {
        task?.cancel()
        
        task = Task {
            let keyword = keyword
            let searchType = searchType
            
            isProgressing = true
            searchedKeyword = ""
            
            do {
                let result = try await withThrowingTaskGroup(of: SearchDeletableAccountTaskGroup.self) { group -> ([DeletableAccountItem], [WithdrawalAccountItem]) in
                    group.addTask { .deletableAccountItems(try await self.requestSearchAccounts(keyword: keyword, searchType: searchType)) }
                    group.addTask { .withdrawalAccountItems(try await self.requestWithdrawalAccounts(keyword: keyword, searchType: searchType)) }
                    
                    var deletableAccountResponse: DeletableAccountSearchResponse?
                    var withdrawalAccountResponse: WithdrawalAccountSearchResponse?
                    
                    for try await value in group {
                        switch value {
                        case .deletableAccountItems(let response):     deletableAccountResponse = response
                        case .withdrawalAccountItems(let response):    withdrawalAccountResponse = response
                        }
                    }
                    
                    return (deletableAccountResponse?.items ?? [], withdrawalAccountResponse?.items ?? [])
                }
                
                self.searchedKeyword = keyword
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    deletableAccountItems = result.0
                    withdrawalAccountItems = result.1
                }
            
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }
    
    func withdraw(item: DeletableAccountItem) {
        task?.cancel()
        task = Task {
            isProgressing = true
            
            do {
                try await requestWithdraw(item: item)
                
                deletableAccountItems.remove(object: item)
                toastMessage = String(localizedFormat: "withdrawAccountMessage", item.id)
            
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }
    
    func removeWithdrawalAccount(item: WithdrawalAccountItem) {
        task?.cancel()
        task = Task {
            isProgressing = true
            
            do {
                try await requestDeleteWithdrawalAccount(userNumber: item.userNumber)
                
                withdrawalAccountItems.remove(object: item)
                toastMessage = String(localizedFormat: "withdrawalAccountCancellationMessage", item.id)
            
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }

    func delete(item: DeletableAccountItem) {
        task?.cancel()
        task = Task {
            isProgressing = true
            
            do {
                try await requestWithdraw(item: item)
                try await requestDeleteWithdrawalAccount(userNumber: item.userNumber)
                
                deletableAccountItems.remove(object: item)
                toastMessage = String(localizedFormat: "deleteAccountMessage", item.id)
            
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }
   
    // MARK: Private
    private func requestSearch(keyword: String, searchType: DeletableAccountSearchType) async throws -> DeletableAccountSearchResponse {
        let request = await URLRequest(httpMethod: .get, url: .searchAccounts)
        
        let requestData = DeletableAccountSearchRequest(keyword: keyword, searchType: searchType)
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)
        
        guard let data = response.data else { throw response.error ?? URLError(.badServerResponse) }
        return try JSONDecoder().decode(Response<DeletableAccountSearchResponse>.self, from: data).data
    }
    
    private func requestWithdraw(item: DeletableAccountItem) async throws {
        var request = await URLRequest(httpMethod: .post, url: .withdrawAccount(item.userNumber))
        request.set(value: .application(.json), field: .contentType)
        request.set(value: .application(.json), field: .accept)
        
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: DeleteAccountRequest(reason: "Test"))
        guard response.statusCode == .ok else { throw response.error ?? URLError(.badServerResponse) }
    }
    
    private func requestDeleteWithdrawalAccount(userNumber: Int) async throws {
        var request = await URLRequest(httpMethod: .post, url: .deleteWithdrawalAccount)
        request.set(value: .application(.json), field: .contentType)
        request.set(value: .application(.json), field: .accept)
        
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: BanUserActiveRequest(userNumber: userNumber))
        guard response.statusCode == .ok else { throw response.error ?? URLError(.badServerResponse) }
    }
    
    private func requestSearchAccounts(keyword: String, searchType: DeletableAccountSearchType) async throws -> DeletableAccountSearchResponse {
        let request = await URLRequest(httpMethod: .get, url: .searchAccounts)
        
        let requestData = DeletableAccountSearchRequest(keyword: keyword, searchType: searchType)
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)
        
        guard let data = response.data else { throw response.error ?? URLError(.badServerResponse) }
        return try JSONDecoder().decode(Response<DeletableAccountSearchResponse>.self, from: data).data
    }
    
    private func requestWithdrawalAccounts(keyword: String, searchType: DeletableAccountSearchType) async throws -> WithdrawalAccountSearchResponse {
        let request = await URLRequest(httpMethod: .get, url: .searchWithdrawalAccounts)
        
        let requestData = WithdrawalAccountSearchRequest(keyword: keyword, searchType: searchType)
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)
        
        guard let data = response.data else { throw response.error ?? URLError(.badServerResponse) }
        return try JSONDecoder().decode(Response<WithdrawalAccountSearchResponse>.self, from: data).data
    }
}
