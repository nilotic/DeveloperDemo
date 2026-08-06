//
//  LocalPushItemView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct LocalPushItemView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: LocalPushItem
    var action: (() -> Void)?
    
    // MARK: Private
    private var logoName: String {
        #if BETA
        return "AppIconBeta60x60"
        
        #else
        return "AppIcon60x60"
        #endif
    }
    
    private var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MM.dd h:mm:ss a")
        return dateFormatter.string(from: data.date)
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        HStack(spacing: 0) {
            logoView
            
            VStack(spacing: 1) {
                titleView
                subtitleView
                bodyView
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 5))
            
            VStack(alignment: .trailing, spacing: 5) {
                dateView
                thumbnailView
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
    
    // MARK: Private
    private var logoView: some View {
        Image(uiImage: UIImage(named: logoName) ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(width: 38, height: 38)
            .cornerRadius(9)
    }
    
    private var titleView: some View {
        Text(data.title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(.black)
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var subtitleView: some View {
        Text(data.subtitle)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.black)
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var bodyView: some View {
        Text(data.body)
            .font(.system(size: 15))
            .foregroundColor(.black)
            .lineLimit(1)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dateView: some View {
        Text(dateString)
            .font(.system(size: 12))
            .foregroundColor(.gray)
            .frame(maxHeight: .infinity, alignment: .topTrailing)
            .frame(height: 15)
    }
    
    @ViewBuilder
    private var thumbnailView: some View {
        if let url = data.url {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(6)
        }
    }
}

#if DEBUG
#Preview {
    List {
        LocalPushItemView(data: .placeholder)
    }
}
#endif

