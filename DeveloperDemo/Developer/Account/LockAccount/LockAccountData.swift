//
//  LockAccountData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class LockAccountData {
    
    // MARK: - Value
    // MARK: Public
    var keyword = ""
    var searchType: EditableAccountSearchType = .userID
    
    private(set) var lockableAccountItems = [EditableAccountItem]()
    private(set) var unlockableAccountItems = [EditableAccountItem]()
    
    private(set) var isProgressing = false
    private(set) var searchedKeyword = ""
    
    var isPresented = false
    var toastMessage = ""
    
    var isEmpty: Bool {
        lockableAccountItems.isEmpty && unlockableAccountItems.isEmpty
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
                let result = try await withThrowingTaskGroup(of: SearchEditableAccountTaskGroup.self) { group -> ([EditableAccountItem], [EditableAccountItem]) in
                    group.addTask { .lockableAccountItems(try await self.requestSearchEditableAccounts(keyword: keyword, searchType: searchType, status: .unlocked)) }
                    group.addTask { .unlockableAccountItems(try await self.requestSearchEditableAccounts(keyword: keyword, searchType: searchType, status: .locked)) }
                    
                    var lockableAccountResponse: EditableAccountSearchResponse?
                    var unlockableAccountResponse: EditableAccountSearchResponse?
                    
                    for try await value in group {
                        switch value {
                        case .lockableAccountItems(let response):      lockableAccountResponse = response
                        case .unlockableAccountItems(let response):    unlockableAccountResponse = response
                        }
                    }
                    
                    return (lockableAccountResponse?.items ?? [], unlockableAccountResponse?.items ?? [])
                }
                
                self.searchedKeyword = keyword
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    lockableAccountItems = result.0
                    unlockableAccountItems = result.1
                }
            
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }
    
    func update(item: EditableAccountItem, status: AccountLockStatus) {
        task?.cancel()
        task = Task {
            isProgressing = true
            
            do {
                try await requestUpdate(item: item, status: status)
                
                var updatedItem = item
                updatedItem.status = status
                
                withAnimation(.spring(response: 0.28, dampingFraction: 0.8)) {
                    switch status {
                    case .locked:
                        lockableAccountItems.remove(object: item)
                        unlockableAccountItems.append(updatedItem)
                        
                    case .unlocked:
                        unlockableAccountItems.remove(object: item)
                        lockableAccountItems.append(updatedItem)
                    }
                }
                
                toastMessage = String(localizedFormat: status == .locked ? "accountLocked" : "accountUnlocked", item.id)
                
            } catch {
                toastMessage = error.localizedDescription
            }
            
            isProgressing = false
            task = nil
        }
    }
    
    // MARK: Private
    private func requestUpdate(item: EditableAccountItem, status: AccountLockStatus) async throws {
        var request = await URLRequest(httpMethod: .put, url: .updateLockStatus(item.userNumber))
        request.set(value: .application(.json), field: .contentType)
        request.set(value: .application(.json), field: .accept)
        
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData:  EditAccountRequest(status: status))
        guard response.statusCode == .ok else { throw response.error ?? URLError(.badServerResponse) }
    }
    
    private func requestSearchEditableAccounts(keyword: String, searchType: EditableAccountSearchType, status: AccountLockStatus) async throws -> EditableAccountSearchResponse {
        let request = await URLRequest(httpMethod: .get, url: .searchAccounts)
        
        let requestData = EditableAccountSearchRequest(keyword: keyword, searchType: searchType, status: status)
        let response = try await NetworkManager.shared.request(urlRequest: request, requestData: requestData)
        
        guard let data = response.data else { throw response.error ?? URLError(.badServerResponse) }
        return try JSONDecoder().decode(Response<EditableAccountSearchResponse>.self, from: data).data
    }
}
