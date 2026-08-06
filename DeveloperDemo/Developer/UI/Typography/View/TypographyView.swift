//
//  TypographyView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TypographyView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var data: Typography
    
    // MARK: Private
    @State private var isTypographyFormViewPresented = false
    @State private var originalData: Typography?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                descriptionView
                ColorPicker("", selection: $data.color, supportsOpacity: true)
            }
            
            contentView
        }
        .padding(.vertical, 20)
        .sheet(isPresented: $isTypographyFormViewPresented) {
            TypographyFormView(data: $data)
        }
        .task {
            guard originalData == nil else { return }
            originalData = data
        }
    }
    
    // MARK: Private
    private var descriptionView: some View {
        Button {
            isTypographyFormViewPresented = true
            
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(String(localized: "fontSize")):")
                        .font(.system(size: 15, weight: .semibold))
                        
                    Text("\(UInt(data.size))")
                        .font(.system(size: 15))
                }
                .foregroundColor(Color(.displayP3, red: 103 / 255, green: 117 / 255, blue: 126 / 255))

                HStack {
                    Text("\(String(localized: "fontWeight")):")
                        .font(.system(size: 15, weight: .semibold))
                    
                    Text(data.weightDescription)
                        .font(.system(size: 15))
                }
                .foregroundColor(Color(.displayP3, red: 103 / 255, green: 117 / 255, blue: 126 / 255))
                
                HStack {
                    Text("\(String(localized: "lineHeight")):")
                        .font(.system(size: 15, weight: .semibold))
                    
                    Text("\(UInt(data.lineHeight))")
                        .font(.system(size: 15))
                }
                .foregroundColor(Color(.displayP3, red: 103 / 255, green: 117 / 255, blue: 126 / 255))
            }
        }
    }
    
    private var contentView: some View {
        Text(data.content)
            .font(data.font)
            .lineSpacing(data.lineSpacing)
            .foregroundColor(data.color)
            .lineLimit(2)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
                guard let originalData else { return }
                data = originalData
            }
    }
}

#if DEBUG
#Preview {
    TypographyView(data: .constant(.placeholder))
        .padding(20)
}
#endif
