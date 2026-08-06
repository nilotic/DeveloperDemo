//
//  ImageContentModeData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

@MainActor
@Observable
final class ImageContentModeData {
    
    // MARK: - Value
    // MARK: Public
    var frameWidth: CGFloat  = 10
    var frameHeight: CGFloat = 10
    
    var maximumSize: CGSize = .zero
    
    var contentModeString = "Scale To Fill"
    var contentModes = ["Scale To Fill", "Aspect To Fit", "Aspect To Fill"]
    
    let cornerRadius: CGFloat = 10
    let thumbnailCornerRadius: CGFloat = 5
    
    var length: CGFloat {
        min(maximumSize.width, maximumSize.height) * 0.8
    }
    
    
    // MARK: - Function
    // MARK: Public
    func update(size: CGSize) {
        maximumSize = size
         
        frameWidth  = length
        frameHeight = length
    }
}
