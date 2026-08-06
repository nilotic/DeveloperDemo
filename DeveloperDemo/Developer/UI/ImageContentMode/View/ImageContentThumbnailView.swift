//
//  ImageContentThumbnailView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ImageContentThumbnailView: View {

    // MARK: - Value
    // MARK: Public
    let data:  UIView.ContentMode
    @Binding var frameWidth: CGFloat
    @Binding var frameHeight: CGFloat
    
    // MARK: Private
    private let cornerRadius: CGFloat = 5
    
    private var contentMode: String {
        switch data {
        case .scaleToFill:      "Scale To Fill"
        case .scaleAspectFit:   "Aspect To Fit"
        case .scaleAspectFill:  "Aspect To Fill"
        default:                ""
        }
    }
    
    
    // MARK: - View
    // MARK: Pubilc
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                imageView
                contentModeView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Private
    private var imageView: some View {
        ZStack {
            Group {
                let image = Image("sampleImage")

                switch data {
                case .scaleToFill:
                    image
                        .resizable()
                        .frame(width: frameWidth / 4, height: frameHeight / 4)
                        .scaledToFill()

                case .scaleAspectFit:
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: frameWidth / 4, height: frameHeight / 4)
                    
                case .scaleAspectFill:
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameWidth / 4, height: frameHeight / 4)
                    
                default:
                    image
                        .resizable()
                        .frame(width: frameWidth / 4, height: frameHeight / 4)
                }
            }
            .mask(thumbnailMaskView)
            .cornerRadius(cornerRadius)
            
            thumbnailFrameView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var contentModeView: some View {
        Text(contentMode)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.gray)
    }
    
    private var thumbnailFrameView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(.cyan, lineWidth: 2)
            .frame(width: frameWidth / 4, height: frameHeight / 4)
    }
    
    private var thumbnailMaskView: some View {
        Color.white
            .frame(width: frameWidth / 4, height: frameHeight / 4)
    }
}

#if DEBUG
#Preview {
    NavigationView {
        ImageContentThumbnailView(data: .scaleAspectFill, frameWidth: .constant(120), frameHeight: .constant(120))
    }
}
#endif
