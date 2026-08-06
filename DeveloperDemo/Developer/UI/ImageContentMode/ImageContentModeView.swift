//
//  ImageContentModeView.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct ImageContentModeView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var data = ImageContentModeData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            Group {
                if #available(iOS 26, *) {
                    contentView
                        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    
                } else {
                    contentView
                }
            }
            .navigationTitle(DeveloperItem.imageContentMode.title)
            .navigationBarTitleDisplayMode(.inline)
            .task { data.update(size: proxy.size) }
        }
    }

    // MARK: Private
    private var contentView: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ZStack {
                    imageView
                    frameView
                }
                .frame(width: data.length, height: data.length)
                .padding(.top, 20)
                
                thumbnailsView
                contentModeView
                slidersView
            }
        }
    }
    
    private var imageView: some View {
        Group {
            let image = Image("sampleImage")

            switch data.contentModeString {
            case "Scale To Fill":
                image
                    .resizable()
                    .frame(width: data.frameWidth, height: data.frameHeight)
                    .scaledToFill()
                
            case "Aspect To Fit":
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: data.frameWidth, height: data.frameHeight)
                
            case "Aspect To Fill":
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: data.frameWidth, height: data.frameHeight)
                
            default:
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: data.frameWidth, height: data.frameHeight)
            }
        }
        .cornerRadius(data.cornerRadius)
        .mask {
            Color.white
                .frame(width: data.frameWidth, height: data.frameHeight)
                .cornerRadius(data.cornerRadius)
        }
    }
    
    private var thumbnailsView: some View {
        HStack(alignment: .bottom) {
            ImageContentThumbnailView(data: .scaleToFill, frameWidth: $data.frameWidth, frameHeight: $data.frameHeight)
            ImageContentThumbnailView(data: .scaleAspectFit, frameWidth: $data.frameWidth, frameHeight: $data.frameHeight)
            ImageContentThumbnailView(data: .scaleAspectFill, frameWidth: $data.frameWidth, frameHeight: $data.frameHeight)
        }
        .frame(height: data.length / 3)
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
    }
    
    private var frameView: some View {
        RoundedRectangle(cornerRadius: data.cornerRadius)
            .stroke(.mint, lineWidth: 3)
            .frame(width: data.frameWidth, height: data.frameHeight)
    }
    
    private var contentModeView: some View {
        HStack {
            Text("contentMode")
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("contentMode", selection: $data.contentModeString) {
                ForEach($data.contentModes, id: \.self) {
                    Text($0.wrappedValue)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
    }
    
    private var slidersView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("frame")
                .font(.system(size: 15, weight: .semibold))
            
            VStack(spacing: 5) {
                Text(String(localizedFormat: "frameSize", data.frameWidth, data.frameHeight))
                    .font(.system(size: 15))
                
                Slider(value: $data.frameWidth, in: 0...data.length)
                    .foregroundColor(.mint)
                
                Slider(value: $data.frameHeight, in: 0...data.length)
                    .foregroundColor(.mint)
            }
            .padding(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 3)
            }
        }
        .padding(20)
    }
    
}

#if DEBUG
#Preview {
    NavigationView {
        ImageContentModeView()
    }
}
#endif
