//
//  ColorPickerWebView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ColorPickerWebView: View {
    
    // MARK: - Value
    // MARK: Public
    let data: ColorPickerWebData
    var completion: (() -> Void)?
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        ColorPickerWebViewRepresentable(htmlString: data.htmlString, completion: completion)
    }
}

#if DEBUG
#Preview {
    ColorPickerWebView(data: .placeholder)
}
#endif

