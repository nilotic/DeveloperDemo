//
//  DeletableAccountItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct DeletableAccountItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: DeletableAccountItem
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 10) {
                HStack {
                    idView
                    nameView
                }
                
                emailView
            }
            
            userNumberView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: Private
    private var idView: some View {
        Text(data.id)
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
            .lineLimit(1)
    }
    
    private var nameView: some View {
        Text("(\(data.name))")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var emailView: some View {
        Text(data.email)
            .font(.system(size: 15))
            .foregroundColor(Color(.displayP3, red: 133 / 255, green: 145 / 255, blue: 158 / 255))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var userNumberView: some View {
        Text(String(data.userNumber))
            .font(.system(size: 15))
            .foregroundColor(Color(.displayP3, red: 126 / 255, green: 67 / 255, blue: 250 / 255))
    }
}

#if DEBUG
#Preview {
    List {
        DeletableAccountItemView(data: .placeholder)
    }
}
#endif
