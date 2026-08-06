//
//  TextFieldAlertView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TextFieldAlertView: View {
    
    // MARK: - Value
    // MARK: Private
    @Bindable var data: DeeplinkerData
    
    
    // MARK: - View
    // MARK: Public
    @ViewBuilder
    var body: some View {
        switch data.textFieldAlert {
        case .none:         SwiftUI.EmptyView()
        case .keyword:      keywordAlertView
        case .coupon:       couponAlertView
        case .number:       numberAlertView
        case .code:         codeAlertView
        case .url:          urlAlertView
        case .orderNumber:  orderNumberAlertView
        case .review:       reviewAlertView
        case .category:     categoryAlertView
        case .collection:   collectionAlertView
        case .goods:        goodsAlertView
        case .games:        gamesAlertView
        }
    }
    
    // MARK: Private
    @ViewBuilder
    private var keywordAlertView: some View {
        TextField("keyword", text: $data.searchKeyword)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var couponAlertView: some View {
        TextField("code", text: $data.code)
            .keyboardType(.numberPad)

        TextField("couponNumber", text: $data.couponNumber)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
       
    @ViewBuilder
    private var numberAlertView: some View {
        TextField("number", text: $data.number)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var codeAlertView: some View {
        TextField("code", text: $data.code)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var urlAlertView: some View {
        TextField("url", text: $data.urlString)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
        
    @ViewBuilder
    private var orderNumberAlertView: some View {
        TextField("orderNumber", text: $data.orderNumber)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
        
    @ViewBuilder
    private var reviewAlertView: some View {
        TextField("dealProductNumber", text: $data.dealProductNumber)
            .keyboardType(.numberPad)
        
        TextField("orderNumber", text: $data.orderNumber)
            .keyboardType(.numberPad)
        
        TextField("contentsProductNumber", text: $data.contentsProductNumber)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var categoryAlertView: some View {
        TextField("category", text: $data.category)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var collectionAlertView: some View {
        TextField("collection", text: $data.collection)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var goodsAlertView: some View {
        TextField("goods", text: $data.goods)
            .keyboardType(.numberPad)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
    
    @ViewBuilder
    private var gamesAlertView: some View {
        TextField("game", text: $data.games)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        
        Button(String(localized: "ok")) { data.updateItem() }
        Button(String(localized: "cancel")) {}
    }
}

#if DEBUG
#Preview {
    ZStack {
        
    }
    .alert("keyword", isPresented: .constant(true)) {
        TextFieldAlertView(data: DeeplinkerData())
    }
}
#endif
