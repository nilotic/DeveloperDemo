//
//  WithdrawalAccountItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct WithdrawalAccountItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: WithdrawalAccountItem
    
    // MARK: Private
    private var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        
        return dateFormatter.string(from: data.date)
    }
        
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                idView
                dateView
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
    
    private var dateView: some View {
        Text(dateString)
            .font(.system(size: 15))
            .foregroundColor(Color(.displayP3, red: 133 / 255, green: 145 / 255, blue: 158 / 255))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var userNumberView: some View {
        Text(String(data.userNumber))
            .font(.system(size: 15))
            .foregroundColor(Color(.displayP3, red: 232 / 255, green: 168 / 255, blue: 40 / 255))
    }
}

#if DEBUG
#Preview {
    List {
        WithdrawalAccountItemView(data: .placeholder)
    }
}
#endif
