//
//  ViewExtension.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

extension View {

    func toast(message: Binding<String>) -> some View {
        modifier(ToastModifier(message: message))
    }
}
