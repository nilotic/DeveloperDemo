//
//  TypographyFormView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct TypographyFormView: View {
    
    // MARK: - Value
    // MARK: Public
    @Binding var data: Typography
    
    // MARK: Private
    @State private var fontSizeString   = ""
    @State private var fontWeightString = ""
    @State private var lineHeightString = ""
    
    @Environment(\.dismiss) private var dismiss
    
    private let fontWeights = [String(localized: "ultraLight"), String(localized: "thin"), String(localized: "light"), 
                               String(localized: "regular"), String(localized: "medium"), 
                               String(localized: "semibold"), String(localized: "bold"), String(localized: "heavy"),
                               String(localized: "black")]
    
    private var fontWeight: Font.Weight {
        switch fontWeightString {
        case String(localized: "ultraLight"):     return .ultraLight
        case String(localized: "thin"):           return .thin
        case String(localized: "light"):          return .light
        case String(localized: "regular"):        return .regular
        case String(localized: "medium"):         return .medium
        case String(localized: "semibold"):       return .semibold
        case String(localized: "bold"):           return .bold
        case String(localized: "heavy"):          return .heavy
        case String(localized: "black"):          return .black
        default:                                  return .regular
        }
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle("font")
        }
        .task {
            fontSizeString   = "\(UInt(data.size))"
            fontWeightString = data.weightDescription
            lineHeightString = "\(UInt(data.lineHeight))"
        }
    }
    
    // MARK: Private
    private var contentView: some View {
        Form {
            fontSizeView
            fontWeightView
            lineHeightView
            doneButton
        }
    }
    
    private var fontSizeView: some View {
        Section("fontSize") {
            TextField("\(UInt(data.size))", text: $fontSizeString)
                .keyboardType(.numberPad)
        }
    }
    
    private var fontWeightView: some View {
        Section("fontWeight") {
            Picker("", selection: $fontWeightString) {
                ForEach(fontWeights, id: \.self) {
                    Text($0)
                }
            }
            .scaledToFit()
            .padding(.leading, -24)
        }
    }
    
    private var lineHeightView: some View {
        Section("lineHeight") {
            TextField("\(UInt(data.lineHeight))", text: $lineHeightString)
                .keyboardType(.numberPad)
        }
    }
    
    private var doneButton: some View {
        Button {
            data.size       = CGFloat(Int(fontSizeString) ?? Int(data.size))
            data.weight     = fontWeight
            data.lineHeight = CGFloat(Int(lineHeightString) ?? Int(data.size))
            
            dismiss()
            
        } label: {
            Text("done")
                .frame(maxWidth: .infinity)
        }
    }
}

#if DEBUG
#Preview {
    TypographyFormView(data: .constant(.placeholder))
}
#endif
