//
//  JSONWebTokenTextField.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

@available(iOS 16, *)
struct JSONWebTokenTextField: View {
 
    // MARK: - Value
    // MARK: Public
    @Binding var text: String
    
    // MARK: Private
    @FocusState private var isFocused: Bool
    
    private var headerAttributedString: AttributedString {
        let components = text.components(separatedBy: ".")
        
        guard !components.isEmpty else { return AttributedString() }
        var attributedString = AttributedString(components[0])
        attributedString.foregroundColor = Color(.displayP3, red: 225 / 255, green: 68 / 255, blue: 117 / 255)
        
        return attributedString
    }
    
    private var payloadAttributedString: AttributedString {
        let components = text.components(separatedBy: ".")
        
        guard 2 <= components.count else { return AttributedString() }
        var attributedString = AttributedString(components[1])
        attributedString.foregroundColor = Color(.displayP3, red: 197 / 255, green: 71 / 255, blue: 247 / 255)
        
        return dotAttributedString + attributedString
    }
    
    private var signatureAttributedString: AttributedString {
        let components = text.components(separatedBy: ".")
        
        guard 3 <= components.count else { return AttributedString() }
        var attributedString = AttributedString(components[2])
        attributedString.foregroundColor = Color(.displayP3, red: 100 / 255, green: 182 / 255, blue: 235 / 255)
        
        return dotAttributedString + attributedString
    }
    
    private var dotAttributedString: AttributedString {
        var attributedString = AttributedString(".")
        attributedString.foregroundColor = .black
        return attributedString
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ZStack(alignment: .topLeading) {
            jsonWebTokenTextView
            textFieldView
        }
        .frame(minHeight: 315, alignment: .topLeading)
    }
    
    // MARK: Private
    private var jsonWebTokenTextView: some View {
        Text(headerAttributedString + payloadAttributedString + signatureAttributedString)
    }
    
    private var textFieldView: some View {
        TextField("jsonWebTokenPlaceholder", text: $text, axis: .vertical)
            .foregroundColor(.clear)
            .accentColor(.black)
            .submitLabel(.done)
            .focused($isFocused)
            .onChange(of: text) {
                guard $0.contains("\n") else { return }
                // Remove "\n"
                text = $0.replacingOccurrences(of: "\n", with: "")
                
                // Dismiss keyboard
                isFocused = false
            }
    }
}

#if DEBUG
@available(iOS 16, *)
#Preview {
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjYXJ0X2lkIjoiYzdmZTYxODktMzI0ZC00NjU2LThkNzYtOWQwNWU3Y2U2MThjIiwiaXNfZ3Vlc3QiOnRydWUsInV1aWQiOm51bGwsIm1fbm8iOm51bGwsIm1faWQiOm51bGwsImxldmVsIjpudWxsLCJzdWIiOm51bGwsImlzcyI6Imh0dHBzOi8vYXBpLmRldi5rdXJseS5jb20vdjMvYXV0aC9yZWZyZXNoIiwiaWF0IjoxNjk2NDg3NjczLCJleHAiOjE2OTY0OTI3MjAsIm5iZiI6MTY5NjQ4OTEyMCwianRpIjoiRm5kNThRYjk1OUk1TWtuYyJ9.CWRsMAvQnyi2aav1NFPs3W1ZSbNfEeGmF3cA_tjgUKQ"
    
    return JSONWebTokenTextField(text: .constant(token))
}
#endif
