//
//  DeeplinkerData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class DeeplinkerData {
    
    // MARK: - Value
    // MARK: Public
    var keyword = "" {
        didSet { search() }
    }
    
    var sections = [DeeplinkSection]()
    private(set) var textFieldAlert: TextFieldAlert = .none
    
    private(set) var isProgressing = false
    
    var searchKeyword = ""
    var code = ""
    var couponNumber = ""
    var number = ""
    var urlString = ""
    var orderNumber = ""
    var contentsProductNumber = ""
    var dealProductNumber = ""
    var category = ""
    var collection = ""
    var goods = ""
    var games = ""
    
    var isAlertPresented = false
    
    var toastMessage = ""
   
    
    // MARK: Private
    @ObservationIgnored
    private var originalSections = [DeeplinkSection]()
    @ObservationIgnored
    private var editableItem: DeeplinkItem? = nil

    @ObservationIgnored
    private var task: Task<Void, Never>? = nil
    
    
    // MARK: - Function
    // MARK: Public
    func request() {
        originalSections = [.home, .search, .myPage, .event, .games, .web, .cart, .order, .product, .gift, .compose, .user, .address, .universalLink]
        sections = originalSections
    }
    
    func handle(item: DeeplinkItem) {
        guard let url = item.deeplink.url, UIApplication.shared.canOpenURL(url) else {
            toastMessage = "Failed to open the deeplink. \(item.deeplink.absoluteString)"
            return
        }
        
        DeepLink(item.deeplink.url)?.go()
    }
    
    func edit(item: DeeplinkItem) {
        editableItem = item
        
        if item.deeplinkKeys.contains(.keyword) {
            searchKeyword  = item.deeplink.components?[.keyword] ?? ""
            textFieldAlert = .keyword
            
            isAlertPresented = true
            
        } else if item.deeplinkKeys.contains(.code) {
            code = item.deeplink.components?[.code] ?? ""
            
            if item.deeplinkKeys.contains(.couponNumber) {
                couponNumber = item.deeplink.components?[.couponNumber] ?? ""
                textFieldAlert = .coupon
                
            } else {
                textFieldAlert = .code
            }
            
            isAlertPresented = true
            
        } else if item.deeplinkKeys.contains(.number) {
            number = item.deeplink.components?[.number] ?? ""
            textFieldAlert = .number
            
            isAlertPresented = true
            
        } else if item.deeplinkKeys.contains(.url) {
            urlString = item.deeplink.components?[.url] ?? ""
            textFieldAlert = .url
            
            isAlertPresented = true
            
        } else if item.deeplink.host == .games {
            games = item.deeplink.path?.rawValue ?? ""
            textFieldAlert = .games
            
            isAlertPresented = true
            
        } else if item.deeplinkKeys.contains(.orderNumber) {
            orderNumber = item.deeplink.components?[.orderNumber] ?? ""
            
            if item.deeplinkKeys.contains(.contentsProductNumber) || item.deeplinkKeys.contains(.dealProductNumber) {
                dealProductNumber = item.deeplink.components?[.dealProductNumber] ?? ""
                contentsProductNumber = item.deeplink.components?[.contentsProductNumber] ?? ""
                textFieldAlert = .review
                
            } else {
                textFieldAlert = .orderNumber
            }

            isAlertPresented = true
            
        } else if let path = item.deeplink.path {
            switch path {
            case .category(let category):
                self.category = category
                textFieldAlert = .category
                
                isAlertPresented = true
                
            case .collection(let collection):
                self.collection = collection
                textFieldAlert = .collection
                
                isAlertPresented = true

            case .goods(let goods):
                self.goods = goods
                textFieldAlert = .goods
                
                isAlertPresented = true

            default:
                break
            }
        }
    }
    
    func copy(item: DeeplinkItem) {
        UIPasteboard.general.string = item.deeplink.absoluteString
        toastMessage = String(localizedFormat: "copiedPasteBoard", item.deeplink.absoluteString)
    }
    
    func updateItem() {
        guard var editableItem else { return }
        isProgressing = true
        
        var sections = sections
        
        // Path
        if let path = editableItem.deeplink.path {
            switch path {
            case .category:     editableItem.deeplink.path = .category(category)
            case .collection:   editableItem.deeplink.path = .collection(collection)
            case .goods:        editableItem.deeplink.path = .goods(goods)
            case .games:        editableItem.deeplink.path = .games(games)
            default:            break
            }
        }
        
        // Query
        for key in editableItem.deeplinkKeys {
            switch key {
            case .keyword:                      editableItem.deeplink.components?[key] = searchKeyword
            case .code:                         editableItem.deeplink.components?[key] = code
            case .couponNumber:                 editableItem.deeplink.components?[key] = couponNumber
            case .number:                       editableItem.deeplink.components?[key] = number
            case .url:                          editableItem.deeplink.components?[key] = urlString
            case .orderNumber:                  editableItem.deeplink.components?[key] = orderNumber
            case .contentsProductNumber:        editableItem.deeplink.components?[key] = contentsProductNumber
            case .dealProductNumber:            editableItem.deeplink.components?[key] = dealProductNumber
            default:                            continue
            }
        }
        
        var matchedIndexPath: IndexPath? {
            for (section, deeplinkSection) in sections.enumerated() {
                for (row, item) in deeplinkSection.items.enumerated() {
                    guard item == editableItem else { continue }
                    return IndexPath(row: row, section: section)
                }
            }
            
            return nil
        }
        
        guard let indexPath = matchedIndexPath else {
            isProgressing = false
            return
        }
        
        sections[indexPath.section].items[indexPath.row] = editableItem
        
        isProgressing = false
        self.sections = sections
    }
    
    // MARK: Private
    func search() {
        task?.cancel()
        task = Task {
            isProgressing = true
            
            do {
                try await Task.sleep(nanoseconds: keyword.isEmpty ? 0 : 1_000_000_000)
                
                let filteredSections = originalSections.reduce([DeeplinkSection]()) { result, section in
                    let items = section.items.filter { $0.title.contains(keyword) || $0.deeplink.absoluteString.contains(keyword) || $0.version.contains(keyword) }
                    
                    guard !items.isEmpty else { return result }
                    return result + [DeeplinkSection(title: section.title, items: items)]
                }
                
                isProgressing = false
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.sections = keyword.isEmpty ? originalSections : filteredSections
                }
            
            } catch { }
        }
    }
}
