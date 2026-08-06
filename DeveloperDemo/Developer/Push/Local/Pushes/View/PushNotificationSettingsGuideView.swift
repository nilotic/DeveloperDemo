//
//  PushNotificationSettingsGuideView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct PushNotificationSettingGuideView: View {
    
    // MARK: - Value
    // MARK: Public
    var action: (() -> Void)?
    
    // MARK: Private
    private var attributedDescriptionString: AttributedString {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? String(localized: "service")
        var attributedString = AttributedString(String(localizedFormat: "systemNotificationSettingsGuide", name))
        
        if let range = attributedString.range(of: "\(String(localized: "settings")) > \(name) > \(String(localized: "notification"))") {
            attributedString[range].foregroundColor = Color(.displayP3, red: 126 / 255, green: 67 / 255, blue: 250 / 255)
        }
        
        return attributedString
    }
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(spacing: 0) {
            titleView
            descriptionView
            settingButton
        }
        .background(Color(.displayP3, red: 237 / 255, green: 240 / 255, blue: 243 / 255))
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .background(.white)
        .contentShape(Rectangle())
    }
    
    // MARK: Private
    private var titleView: some View {
        Text("systemNotificationSettings")
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(Color(.displayP3, red: 34 / 255, green: 34 / 255, blue: 34 / 255))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 19, leading: 20, bottom: 0, trailing: 0))
    }
    
    private var descriptionView: some View {
        Text(attributedDescriptionString)
            .font(.system(size: 14))
            .foregroundColor(Color(.displayP3, red: 99 / 255, green: 102 / 255, blue: 113 / 255))
            .lineSpacing(20 - UIFont.systemFont(ofSize: 14).lineHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 7, leading: 20, bottom: 0, trailing: 20))
    }
    
    private var settingButton: some View {
        Button {
            action?()
            
        } label: {
            Text("setUp")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color(.displayP3, red: 126 / 255, green: 67 / 255, blue: 250 / 255))
                .cornerRadius(20)
        }
        .padding(EdgeInsets(top: 22, leading: 20, bottom: 20, trailing: 20))
    }
}

#if DEBUG
#Preview {
    PushNotificationSettingGuideView()
}
#endif
