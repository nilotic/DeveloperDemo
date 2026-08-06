//
//  Colors.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI
import UIKit

private func designSystemColor(
    light: (CGFloat, CGFloat, CGFloat, CGFloat),
    dark: (CGFloat, CGFloat, CGFloat, CGFloat)
) -> Color {
    Color(UIColor { traits in
        let c = traits.userInterfaceStyle == .dark ? dark : light
        return UIColor(displayP3Red: c.0, green: c.1, blue: c.2, alpha: c.3)
    })
}

extension Color {

    static let background1 = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (0.1098, 0.1098, 0.1098, 1.0000))
    static let background1Universal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let background2 = designSystemColor(light: (0.9490, 0.9608, 0.9725, 1.0000), dark: (0.1333, 0.1333, 0.1333, 1.0000))
    static let background3 = designSystemColor(light: (0.9255, 0.9373, 0.9529, 1.0000), dark: (0.1882, 0.2000, 0.2157, 1.0000))
    static let background4 = designSystemColor(light: (0.8745, 0.8941, 0.9216, 1.0000), dark: (0.2118, 0.2275, 0.2510, 1.0000))
    static let background5 = designSystemColor(light: (0.7961, 0.8196, 0.8431, 1.0000), dark: (0.2745, 0.2941, 0.3216, 1.0000))
    static let background6 = designSystemColor(light: (0.7373, 0.7686, 0.8000, 1.0000), dark: (0.3137, 0.3412, 0.3765, 1.0000))
    static let blackAlphaBold = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.7000), dark: (1.0000, 1.0000, 1.0000, 0.7000))
    static let blackAlphaBoldUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.7000), dark: (0.0000, 0.0000, 0.0000, 0.7000))
    static let blackAlphaLight = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.2000), dark: (1.0000, 1.0000, 1.0000, 0.2000))
    static let blackAlphaLightUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.2000), dark: (0.0000, 0.0000, 0.0000, 0.2000))
    static let blackAlphaRegular = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.5000), dark: (1.0000, 1.0000, 1.0000, 0.5000))
    static let blackAlphaRegularUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.5000), dark: (0.0000, 0.0000, 0.0000, 0.5000))
    static let blackMain = designSystemColor(light: (0.0000, 0.0000, 0.0000, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let blackUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 1.0000), dark: (0.0000, 0.0000, 0.0000, 1.0000))
    static let blue100 = designSystemColor(light: (0.8745, 0.9216, 0.9765, 1.0000), dark: (0.0980, 0.1451, 0.1922, 1.0000))
    static let blue200 = designSystemColor(light: (0.7843, 0.8706, 0.9569, 1.0000), dark: (0.0902, 0.1686, 0.2510, 1.0000))
    static let blue300 = designSystemColor(light: (0.6863, 0.8078, 0.9373, 1.0000), dark: (0.0824, 0.1922, 0.3137, 1.0000))
    static let blue400 = designSystemColor(light: (0.6000, 0.7529, 0.9176, 1.0000), dark: (0.0745, 0.2157, 0.3725, 1.0000))
    static let blue50 = designSystemColor(light: (0.9412, 0.9647, 0.9882, 1.0000), dark: (0.1059, 0.1255, 0.1490, 1.0000))
    static let blue500 = designSystemColor(light: (0.5020, 0.6941, 0.9020, 1.0000), dark: (0.0627, 0.2431, 0.4353, 1.0000))
    static let blue600 = designSystemColor(light: (0.4118, 0.6392, 0.8824, 1.0000), dark: (0.0549, 0.2667, 0.4941, 1.0000))
    static let blue700 = designSystemColor(light: (0.3137, 0.5804, 0.8627, 1.0000), dark: (0.0471, 0.2941, 0.5569, 1.0000))
    static let blue800 = designSystemColor(light: (0.2275, 0.5255, 0.8471, 1.0000), dark: (0.0392, 0.3176, 0.6157, 1.0000))
    static let blue850 = designSystemColor(light: (0.1294, 0.4667, 0.8275, 1.0000), dark: (0.0314, 0.3451, 0.6784, 1.0000))
    static let blue900 = designSystemColor(light: (0.0196, 0.4000, 0.8039, 1.0000), dark: (0.0196, 0.3725, 0.7490, 1.0000))
    static let blue950 = designSystemColor(light: (0.0235, 0.3647, 0.7294, 1.0000), dark: (0.0275, 0.4157, 0.8275, 1.0000))
    static let bright = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (0.0000, 0.0000, 0.0000, 1.0000))
    static let brightAlphaBold = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.7000), dark: (0.0000, 0.0000, 0.0000, 0.7000))
    static let brightAlphaBoldUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.7000), dark: (1.0000, 1.0000, 1.0000, 0.7000))
    static let brightAlphaLight = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.2000), dark: (0.0000, 0.0000, 0.0000, 0.2000))
    static let brightAlphaLightUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.2000), dark: (1.0000, 1.0000, 1.0000, 0.2000))
    static let brightAlphaRegular = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.5000), dark: (0.0000, 0.0000, 0.0000, 0.5000))
    static let brightAlphaRegularUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.5000), dark: (1.0000, 1.0000, 1.0000, 0.5000))
    static let brightUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let brown100 = designSystemColor(light: (0.9490, 0.9176, 0.8863, 1.0000), dark: (0.1686, 0.1412, 0.1098, 1.0000))
    static let brown200 = designSystemColor(light: (0.9176, 0.8588, 0.8078, 1.0000), dark: (0.2118, 0.1608, 0.1098, 1.0000))
    static let brown300 = designSystemColor(light: (0.8784, 0.7961, 0.7176, 1.0000), dark: (0.2588, 0.1843, 0.1098, 1.0000))
    static let brown400 = designSystemColor(light: (0.8431, 0.7373, 0.6392, 1.0000), dark: (0.3020, 0.2039, 0.1098, 1.0000))
    static let brown50 = designSystemColor(light: (0.9765, 0.9608, 0.9490, 1.0000), dark: (0.1373, 0.1216, 0.1098, 1.0000))
    static let brown500 = designSystemColor(light: (0.8078, 0.6745, 0.5529, 1.0000), dark: (0.3490, 0.2275, 0.1137, 1.0000))
    static let brown600 = designSystemColor(light: (0.7725, 0.6157, 0.4745, 1.0000), dark: (0.3882, 0.2471, 0.1137, 1.0000))
    static let brown700 = designSystemColor(light: (0.7333, 0.5529, 0.3843, 1.0000), dark: (0.4353, 0.2706, 0.1137, 1.0000))
    static let brown800 = designSystemColor(light: (0.6980, 0.4941, 0.3059, 1.0000), dark: (0.4784, 0.2902, 0.1137, 1.0000))
    static let brown850 = designSystemColor(light: (0.6627, 0.4314, 0.2196, 1.0000), dark: (0.5255, 0.3137, 0.1137, 1.0000))
    static let brown900 = designSystemColor(light: (0.6196, 0.3608, 0.1216, 1.0000), dark: (0.5765, 0.3373, 0.1137, 1.0000))
    static let brown950 = designSystemColor(light: (0.5608, 0.3255, 0.1137, 1.0000), dark: (0.6471, 0.3765, 0.1216, 1.0000))
    static let dim = designSystemColor(light: (0.0000, 0.0000, 0.0000, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let dimAlphaBold = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.7000), dark: (1.0000, 1.0000, 1.0000, 0.7000))
    static let dimAlphaBoldUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.7000), dark: (0.0000, 0.0000, 0.0000, 0.7000))
    static let dimAlphaLight = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.2000), dark: (1.0000, 1.0000, 1.0000, 0.2000))
    static let dimAlphaLightUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.2000), dark: (0.0000, 0.0000, 0.0000, 0.2000))
    static let dimAlphaPaleUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.0500), dark: (0.0000, 0.0000, 0.0000, 0.0500))
    static let dimAlphaRegular = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.5000), dark: (1.0000, 1.0000, 1.0000, 0.5000))
    static let dimAlphaRegularUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 0.5000), dark: (0.0000, 0.0000, 0.0000, 0.5000))
    static let dimUniversal = designSystemColor(light: (0.0000, 0.0000, 0.0000, 1.0000), dark: (0.0000, 0.0000, 0.0000, 1.0000))
    static let disabled = designSystemColor(light: (0.7373, 0.7686, 0.8000, 1.0000), dark: (0.3137, 0.3412, 0.3765, 1.0000))
    static let gray100 = designSystemColor(light: (0.9255, 0.9373, 0.9529, 1.0000), dark: (0.1882, 0.2000, 0.2157, 1.0000))
    static let gray200 = designSystemColor(light: (0.8745, 0.8941, 0.9216, 1.0000), dark: (0.2118, 0.2275, 0.2510, 1.0000))
    static let gray300 = designSystemColor(light: (0.7961, 0.8196, 0.8431, 1.0000), dark: (0.2745, 0.2941, 0.3216, 1.0000))
    static let gray400 = designSystemColor(light: (0.7373, 0.7686, 0.8000, 1.0000), dark: (0.3137, 0.3412, 0.3765, 1.0000))
    static let gray50 = designSystemColor(light: (0.9490, 0.9608, 0.9725, 1.0000), dark: (0.1333, 0.1333, 0.1333, 1.0000))
    static let gray500 = designSystemColor(light: (0.6549, 0.6980, 0.7373, 1.0000), dark: (0.3843, 0.4235, 0.4667, 1.0000))
    static let gray600 = designSystemColor(light: (0.5176, 0.5608, 0.6039, 1.0000), dark: (0.5176, 0.5608, 0.6039, 1.0000))
    static let gray700 = designSystemColor(light: (0.3373, 0.3686, 0.4039, 1.0000), dark: (0.6549, 0.6980, 0.7373, 1.0000))
    static let gray800 = designSystemColor(light: (0.2745, 0.2980, 0.3216, 1.0000), dark: (0.7529, 0.7843, 0.8157, 1.0000))
    static let gray850 = designSystemColor(light: (0.2235, 0.2392, 0.2549, 1.0000), dark: (0.8667, 0.8863, 0.9098, 1.0000))
    static let gray900 = designSystemColor(light: (0.1333, 0.1333, 0.1333, 1.0000), dark: (0.9490, 0.9608, 0.9725, 1.0000))
    static let gray950 = designSystemColor(light: (0.1098, 0.1098, 0.1098, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let green100 = designSystemColor(light: (0.8706, 0.9451, 0.9216, 1.0000), dark: (0.0980, 0.1647, 0.1451, 1.0000))
    static let green200 = designSystemColor(light: (0.7804, 0.9098, 0.8706, 1.0000), dark: (0.0863, 0.2039, 0.1686, 1.0000))
    static let green300 = designSystemColor(light: (0.6824, 0.8667, 0.8118, 1.0000), dark: (0.0784, 0.2510, 0.1961, 1.0000))
    static let green400 = designSystemColor(light: (0.5922, 0.8314, 0.7569, 1.0000), dark: (0.0667, 0.2902, 0.2196, 1.0000))
    static let green50 = designSystemColor(light: (0.9412, 0.9765, 0.9647, 1.0000), dark: (0.1020, 0.1373, 0.1255, 1.0000))
    static let green500 = designSystemColor(light: (0.4941, 0.7882, 0.6980, 1.0000), dark: (0.0588, 0.3333, 0.2471, 1.0000))
    static let green600 = designSystemColor(light: (0.4039, 0.7490, 0.6431, 1.0000), dark: (0.0471, 0.3725, 0.2706, 1.0000))
    static let green700 = designSystemColor(light: (0.3059, 0.7098, 0.5843, 1.0000), dark: (0.0392, 0.4157, 0.2980, 1.0000))
    static let green800 = designSystemColor(light: (0.2157, 0.6706, 0.5333, 1.0000), dark: (0.0275, 0.4549, 0.3216, 1.0000))
    static let green850 = designSystemColor(light: (0.1176, 0.6314, 0.4745, 1.0000), dark: (0.0196, 0.4980, 0.3490, 1.0000))
    static let green900 = designSystemColor(light: (0.0078, 0.5843, 0.4078, 1.0000), dark: (0.0078, 0.5451, 0.3804, 1.0000))
    static let green950 = designSystemColor(light: (0.0667, 0.5451, 0.4000, 1.0000), dark: (0.0039, 0.6118, 0.4235, 1.0000))
    static let kakao = designSystemColor(light: (0.9961, 0.8980, 0.0000, 1.0000), dark: (0.9451, 0.8510, 0.0078, 1.0000))
    static let kakaoYellow100 = designSystemColor(light: (1.0000, 0.9882, 0.8706, 1.0000), dark: (0.2196, 0.2078, 0.0980, 1.0000))
    static let kakaoYellow200 = designSystemColor(light: (1.0000, 0.9765, 0.7804, 1.0000), dark: (0.2941, 0.2745, 0.0863, 1.0000))
    static let kakaoYellow300 = designSystemColor(light: (1.0000, 0.9686, 0.6784, 1.0000), dark: (0.3765, 0.3451, 0.0784, 1.0000))
    static let kakaoYellow400 = designSystemColor(light: (1.0000, 0.9569, 0.5882, 1.0000), dark: (0.4510, 0.4118, 0.0667, 1.0000))
    static let kakaoYellow50 = designSystemColor(light: (1.0000, 0.9922, 0.9412, 1.0000), dark: (0.1608, 0.1529, 0.1020, 1.0000))
    static let kakaoYellow500 = designSystemColor(light: (1.0000, 0.9490, 0.4902, 1.0000), dark: (0.5373, 0.4863, 0.0588, 1.0000))
    static let kakaoYellow600 = designSystemColor(light: (0.9961, 0.9373, 0.4000, 1.0000), dark: (0.6118, 0.5529, 0.0471, 1.0000))
    static let kakaoYellow700 = designSystemColor(light: (0.9961, 0.9294, 0.2980, 1.0000), dark: (0.6941, 0.6275, 0.0392, 1.0000))
    static let kakaoYellow800 = designSystemColor(light: (0.9961, 0.9176, 0.2118, 1.0000), dark: (0.7686, 0.6941, 0.0275, 1.0000))
    static let kakaoYellow850 = designSystemColor(light: (0.9961, 0.9098, 0.1098, 1.0000), dark: (0.8549, 0.7686, 0.0196, 1.0000))
    static let kakaoYellow900 = designSystemColor(light: (0.9961, 0.8980, 0.0000, 1.0000), dark: (0.9451, 0.8510, 0.0078, 1.0000))
    static let kakaoYellow950 = designSystemColor(light: (0.9647, 0.8745, 0.0471, 1.0000), dark: (0.9961, 0.9020, 0.0353, 1.0000))
    static let line1 = designSystemColor(light: (0.9255, 0.9373, 0.9529, 1.0000), dark: (0.1882, 0.2000, 0.2157, 1.0000))
    static let line2 = designSystemColor(light: (0.8745, 0.8941, 0.9216, 1.0000), dark: (0.2118, 0.2275, 0.2510, 1.0000))
    static let mainComplete = designSystemColor(light: (0.0078, 0.5843, 0.4078, 1.0000), dark: (0.0078, 0.5451, 0.3804, 1.0000))
    static let mainCompleteContainer = designSystemColor(light: (0.8706, 0.9451, 0.9216, 1.0000), dark: (0.0980, 0.1647, 0.1451, 1.0000))
    static let mainDanger = designSystemColor(light: (0.8863, 0.1765, 0.1804, 1.0000), dark: (0.8235, 0.1647, 0.1686, 1.0000))
    static let mainDangerContainer = designSystemColor(light: (0.9843, 0.8941, 0.8941, 1.0000), dark: (0.2039, 0.1176, 0.1176, 1.0000))
    static let mainPrimary = designSystemColor(light: (0.4039, 0.1255, 0.5686, 1.0000), dark: (0.5529, 0.2980, 0.7686, 1.0000))
    static let mainPrimaryContainer = designSystemColor(light: (0.9098, 0.8588, 0.9529, 1.0000), dark: (0.1686, 0.1333, 0.1961, 1.0000))
    static let mainSecondary = designSystemColor(light: (0.1333, 0.1333, 0.1333, 1.0000), dark: (0.9490, 0.9608, 0.9725, 1.0000))
    static let mainSecondaryContainer = designSystemColor(light: (0.9255, 0.9373, 0.9529, 1.0000), dark: (0.1882, 0.2000, 0.2157, 1.0000))
    static let mainTertiary = designSystemColor(light: (0.9804, 0.3843, 0.1843, 1.0000), dark: (0.9216, 0.3333, 0.1333, 1.0000))
    static let mainTertiaryContainer = designSystemColor(light: (0.9961, 0.9216, 0.8941, 1.0000), dark: (0.2157, 0.1373, 0.1137, 1.0000))
    static let members = designSystemColor(light: (0.3020, 0.7451, 0.8431, 1.0000), dark: (0.2824, 0.6941, 0.7843, 1.0000))
    static let mint100 = designSystemColor(light: (0.9098, 0.9686, 0.9804, 1.0000), dark: (0.1333, 0.1843, 0.1961, 1.0000))
    static let mint200 = designSystemColor(light: (0.8471, 0.9451, 0.9647, 1.0000), dark: (0.1490, 0.2392, 0.2588, 1.0000))
    static let mint300 = designSystemColor(light: (0.7765, 0.9176, 0.9490, 1.0000), dark: (0.1647, 0.2980, 0.3255, 1.0000))
    static let mint400 = designSystemColor(light: (0.7137, 0.8941, 0.9373, 1.0000), dark: (0.1804, 0.3490, 0.3843, 1.0000))
    static let mint50 = designSystemColor(light: (0.9569, 0.9843, 0.9922, 1.0000), dark: (0.1216, 0.1451, 0.1490, 1.0000))
    static let mint500 = designSystemColor(light: (0.6431, 0.8706, 0.9216, 1.0000), dark: (0.1961, 0.4078, 0.4549, 1.0000))
    static let mint600 = designSystemColor(light: (0.5804, 0.8471, 0.9059, 1.0000), dark: (0.2118, 0.4588, 0.5137, 1.0000))
    static let mint700 = designSystemColor(light: (0.5098, 0.8196, 0.8902, 1.0000), dark: (0.2314, 0.5176, 0.5804, 1.0000))
    static let mint800 = designSystemColor(light: (0.4471, 0.8000, 0.8745, 1.0000), dark: (0.2471, 0.5725, 0.6431, 1.0000))
    static let mint850 = designSystemColor(light: (0.3804, 0.7725, 0.8588, 1.0000), dark: (0.2627, 0.6314, 0.7098, 1.0000))
    static let mint900 = designSystemColor(light: (0.3020, 0.7451, 0.8431, 1.0000), dark: (0.2824, 0.6941, 0.7843, 1.0000))
    static let mint950 = designSystemColor(light: (0.1882, 0.6980, 0.8118, 1.0000), dark: (0.2706, 0.7373, 0.8392, 1.0000))
    static let orange100 = designSystemColor(light: (0.9961, 0.9216, 0.8941, 1.0000), dark: (0.2157, 0.1373, 0.1137, 1.0000))
    static let orange200 = designSystemColor(light: (0.9961, 0.8627, 0.8196, 1.0000), dark: (0.2902, 0.1569, 0.1137, 1.0000))
    static let orange300 = designSystemColor(light: (0.9922, 0.8039, 0.7373, 1.0000), dark: (0.3686, 0.1804, 0.1176, 1.0000))
    static let orange400 = designSystemColor(light: (0.9922, 0.7490, 0.6667, 1.0000), dark: (0.4431, 0.2000, 0.1216, 1.0000))
    static let orange50 = designSystemColor(light: (1.0000, 0.9647, 0.9529, 1.0000), dark: (0.1569, 0.1216, 0.1098, 1.0000))
    static let orange500 = designSystemColor(light: (0.9922, 0.6863, 0.5843, 1.0000), dark: (0.5255, 0.2235, 0.1216, 1.0000))
    static let orange600 = designSystemColor(light: (0.9882, 0.6314, 0.5098, 1.0000), dark: (0.5961, 0.2431, 0.1255, 1.0000))
    static let orange700 = designSystemColor(light: (0.9882, 0.5686, 0.4275, 1.0000), dark: (0.6784, 0.2667, 0.1255, 1.0000))
    static let orange800 = designSystemColor(light: (0.9843, 0.5137, 0.3569, 1.0000), dark: (0.7529, 0.2863, 0.1294, 1.0000))
    static let orange850 = designSystemColor(light: (0.9843, 0.4510, 0.2745, 1.0000), dark: (0.8314, 0.3098, 0.1333, 1.0000))
    static let orange900 = designSystemColor(light: (0.9804, 0.3843, 0.1843, 1.0000), dark: (0.9216, 0.3333, 0.1333, 1.0000))
    static let orange950 = designSystemColor(light: (0.9765, 0.3137, 0.0980, 1.0000), dark: (1.0000, 0.3765, 0.1686, 1.0000))
    static let point1 = designSystemColor(light: (0.7412, 0.4627, 1.0000, 1.0000), dark: (0.6902, 0.4314, 0.9294, 1.0000))
    static let point2 = designSystemColor(light: (0.5529, 0.2980, 0.7686, 1.0000), dark: (0.4588, 0.2588, 0.6314, 1.0000))
    static let purple100 = designSystemColor(light: (0.9098, 0.8588, 0.9529, 1.0000), dark: (0.1686, 0.1333, 0.1961, 1.0000))
    static let purple200 = designSystemColor(light: (0.8627, 0.7804, 0.9294, 1.0000), dark: (0.2078, 0.1529, 0.2549, 1.0000))
    static let purple300 = designSystemColor(light: (0.8078, 0.6980, 0.9020, 1.0000), dark: (0.2510, 0.1686, 0.3216, 1.0000))
    static let purple400 = designSystemColor(light: (0.7569, 0.6196, 0.8745, 1.0000), dark: (0.2902, 0.1882, 0.3804, 1.0000))
    static let purple50 = designSystemColor(light: (0.9608, 0.9373, 0.9804, 1.0000), dark: (0.1373, 0.1216, 0.1490, 1.0000))
    static let purple500 = designSystemColor(light: (0.7059, 0.5373, 0.8471, 1.0000), dark: (0.3373, 0.2039, 0.4471, 1.0000))
    static let purple600 = designSystemColor(light: (0.6549, 0.4588, 0.8235, 1.0000), dark: (0.3765, 0.2235, 0.5059, 1.0000))
    static let purple700 = designSystemColor(light: (0.6039, 0.3765, 0.7922, 1.0000), dark: (0.4196, 0.2431, 0.5725, 1.0000))
    static let purple800 = designSystemColor(light: (0.5529, 0.2980, 0.7686, 1.0000), dark: (0.4588, 0.2588, 0.6314, 1.0000))
    static let purple850 = designSystemColor(light: (0.4941, 0.2275, 0.6902, 1.0000), dark: (0.5059, 0.2784, 0.6980, 1.0000))
    static let purple900 = designSystemColor(light: (0.4039, 0.1255, 0.5686, 1.0000), dark: (0.5529, 0.2980, 0.7686, 1.0000))
    static let purple950 = designSystemColor(light: (0.3725, 0.0000, 0.5020, 1.0000), dark: (0.6235, 0.3255, 0.8784, 1.0000))
    static let red100 = designSystemColor(light: (0.9843, 0.8941, 0.8941, 1.0000), dark: (0.2039, 0.1176, 0.1176, 1.0000))
    static let red200 = designSystemColor(light: (0.9765, 0.8196, 0.8196, 1.0000), dark: (0.2667, 0.1216, 0.1216, 1.0000))
    static let red300 = designSystemColor(light: (0.9647, 0.7373, 0.7373, 1.0000), dark: (0.3373, 0.1255, 0.1294, 1.0000))
    static let red400 = designSystemColor(light: (0.9529, 0.6627, 0.6627, 1.0000), dark: (0.4039, 0.1333, 0.1333, 1.0000))
    static let red50 = designSystemColor(light: (0.9922, 0.9490, 0.9490, 1.0000), dark: (0.1529, 0.1137, 0.1137, 1.0000))
    static let red500 = designSystemColor(light: (0.9412, 0.5804, 0.5843, 1.0000), dark: (0.4745, 0.1373, 0.1412, 1.0000))
    static let red600 = designSystemColor(light: (0.9333, 0.5059, 0.5098, 1.0000), dark: (0.5373, 0.1412, 0.1451, 1.0000))
    static let red700 = designSystemColor(light: (0.9216, 0.4235, 0.4275, 1.0000), dark: (0.6078, 0.1490, 0.1529, 1.0000))
    static let red800 = designSystemColor(light: (0.9098, 0.3490, 0.3529, 1.0000), dark: (0.6745, 0.1529, 0.1569, 1.0000))
    static let red850 = designSystemColor(light: (0.8980, 0.2667, 0.2706, 1.0000), dark: (0.7451, 0.1569, 0.1608, 1.0000))
    static let red900 = designSystemColor(light: (0.8863, 0.1765, 0.1804, 1.0000), dark: (0.8235, 0.1647, 0.1686, 1.0000))
    static let red950 = designSystemColor(light: (0.8471, 0.1059, 0.1098, 1.0000), dark: (0.9137, 0.1529, 0.1569, 1.0000))
    static let textInverse = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (0.1098, 0.1098, 0.1098, 1.0000))
    static let textInverseUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let textPrimary = designSystemColor(light: (0.1333, 0.1333, 0.1333, 1.0000), dark: (0.9490, 0.9608, 0.9725, 1.0000))
    static let textQuaternary = designSystemColor(light: (0.6549, 0.6980, 0.7373, 1.0000), dark: (0.3843, 0.4235, 0.4667, 1.0000))
    static let textSecondary = designSystemColor(light: (0.3373, 0.3686, 0.4039, 1.0000), dark: (0.6549, 0.6980, 0.7373, 1.0000))
    static let textTertiary = designSystemColor(light: (0.5176, 0.5608, 0.6039, 1.0000), dark: (0.5176, 0.5608, 0.6039, 1.0000))
    static let violet100 = designSystemColor(light: (0.9647, 0.9294, 1.0000, 1.0000), dark: (0.1843, 0.1529, 0.2157, 1.0000))
    static let violet200 = designSystemColor(light: (0.9412, 0.8824, 1.0000, 1.0000), dark: (0.2392, 0.1804, 0.2902, 1.0000))
    static let violet300 = designSystemColor(light: (0.9176, 0.8275, 1.0000, 1.0000), dark: (0.2941, 0.2118, 0.3725, 1.0000))
    static let violet400 = designSystemColor(light: (0.8941, 0.7804, 1.0000, 1.0000), dark: (0.3490, 0.2431, 0.4471, 1.0000))
    static let violet50 = designSystemColor(light: (0.9843, 0.9686, 1.0000, 1.0000), dark: (0.1451, 0.1294, 0.1608, 1.0000))
    static let violet500 = designSystemColor(light: (0.8667, 0.7255, 1.0000, 1.0000), dark: (0.4039, 0.2745, 0.5294, 1.0000))
    static let violet600 = designSystemColor(light: (0.8431, 0.6784, 1.0000, 1.0000), dark: (0.4588, 0.3020, 0.6000, 1.0000))
    static let violet700 = designSystemColor(light: (0.8196, 0.6235, 1.0000, 1.0000), dark: (0.5176, 0.3333, 0.6824, 1.0000))
    static let violet800 = designSystemColor(light: (0.7961, 0.5765, 1.0000, 1.0000), dark: (0.5686, 0.3647, 0.7569, 1.0000))
    static let violet850 = designSystemColor(light: (0.7686, 0.5216, 1.0000, 1.0000), dark: (0.6275, 0.3961, 0.8392, 1.0000))
    static let violet900 = designSystemColor(light: (0.7412, 0.4627, 1.0000, 1.0000), dark: (0.6902, 0.4314, 0.9294, 1.0000))
    static let violet950 = designSystemColor(light: (0.6941, 0.3686, 1.0000, 1.0000), dark: (0.7451, 0.4667, 1.0000, 1.0000))
    static let vip = designSystemColor(light: (0.3451, 0.1137, 0.5373, 1.0000), dark: (0.3451, 0.1137, 0.5373, 1.0000))
    static let vvip = designSystemColor(light: (0.2706, 0.1059, 0.4235, 1.0000), dark: (0.2706, 0.1059, 0.4235, 1.0000))
    static let whiteAlphaBold = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.7000), dark: (0.0000, 0.0000, 0.0000, 0.7000))
    static let whiteAlphaBoldUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.7000), dark: (1.0000, 1.0000, 1.0000, 0.7000))
    static let whiteAlphaLight = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.2000), dark: (0.0000, 0.0000, 0.0000, 0.2000))
    static let whiteAlphaLightUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.2000), dark: (1.0000, 1.0000, 1.0000, 0.2000))
    static let whiteAlphaRegular = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.5000), dark: (0.0000, 0.0000, 0.0000, 0.5000))
    static let whiteAlphaRegularUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 0.5000), dark: (1.0000, 1.0000, 1.0000, 0.5000))
    static let whiteInverse = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (0.1098, 0.1098, 0.1098, 1.0000))
    static let whiteMain = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (0.0000, 0.0000, 0.0000, 1.0000))
    static let whiteUniversal = designSystemColor(light: (1.0000, 1.0000, 1.0000, 1.0000), dark: (1.0000, 1.0000, 1.0000, 1.0000))
    static let yellow100 = designSystemColor(light: (0.9922, 0.9608, 0.8706, 1.0000), dark: (0.2078, 0.1804, 0.0941, 1.0000))
    static let yellow200 = designSystemColor(light: (0.9843, 0.9333, 0.7804, 1.0000), dark: (0.2745, 0.2275, 0.0863, 1.0000))
    static let yellow300 = designSystemColor(light: (0.9765, 0.9020, 0.6784, 1.0000), dark: (0.3490, 0.2824, 0.0745, 1.0000))
    static let yellow400 = designSystemColor(light: (0.9725, 0.8745, 0.5882, 1.0000), dark: (0.4196, 0.3333, 0.0667, 1.0000))
    static let yellow50 = designSystemColor(light: (0.9961, 0.9804, 0.9412, 1.0000), dark: (0.1569, 0.1412, 0.1020, 1.0000))
    static let yellow500 = designSystemColor(light: (0.9647, 0.8471, 0.4902, 1.0000), dark: (0.4941, 0.3843, 0.0549, 1.0000))
    static let yellow600 = designSystemColor(light: (0.9569, 0.8196, 0.4000, 1.0000), dark: (0.5608, 0.4353, 0.0431, 1.0000))
    static let yellow700 = designSystemColor(light: (0.9490, 0.7882, 0.2980, 1.0000), dark: (0.6353, 0.4902, 0.0314, 1.0000))
    static let yellow800 = designSystemColor(light: (0.9451, 0.7608, 0.2118, 1.0000), dark: (0.7059, 0.5373, 0.0235, 1.0000))
    static let yellow850 = designSystemColor(light: (0.9373, 0.7294, 0.1098, 1.0000), dark: (0.7804, 0.5922, 0.0118, 1.0000))
    static let yellow900 = designSystemColor(light: (0.9294, 0.6980, 0.0000, 1.0000), dark: (0.8627, 0.6510, 0.0000, 1.0000))
    static let yellow950 = designSystemColor(light: (0.8706, 0.6549, 0.0078, 1.0000), dark: (0.9294, 0.7059, 0.0118, 1.0000))
}

extension ShapeStyle where Self == Color {

    static var background1: Color { .background1 }
    static var background1Universal: Color { .background1Universal }
    static var background2: Color { .background2 }
    static var background3: Color { .background3 }
    static var background4: Color { .background4 }
    static var background5: Color { .background5 }
    static var background6: Color { .background6 }
    static var blackAlphaBold: Color { .blackAlphaBold }
    static var blackAlphaBoldUniversal: Color { .blackAlphaBoldUniversal }
    static var blackAlphaLight: Color { .blackAlphaLight }
    static var blackAlphaLightUniversal: Color { .blackAlphaLightUniversal }
    static var blackAlphaRegular: Color { .blackAlphaRegular }
    static var blackAlphaRegularUniversal: Color { .blackAlphaRegularUniversal }
    static var blackMain: Color { .blackMain }
    static var blackUniversal: Color { .blackUniversal }
    static var blue100: Color { .blue100 }
    static var blue200: Color { .blue200 }
    static var blue300: Color { .blue300 }
    static var blue400: Color { .blue400 }
    static var blue50: Color { .blue50 }
    static var blue500: Color { .blue500 }
    static var blue600: Color { .blue600 }
    static var blue700: Color { .blue700 }
    static var blue800: Color { .blue800 }
    static var blue850: Color { .blue850 }
    static var blue900: Color { .blue900 }
    static var blue950: Color { .blue950 }
    static var bright: Color { .bright }
    static var brightAlphaBold: Color { .brightAlphaBold }
    static var brightAlphaBoldUniversal: Color { .brightAlphaBoldUniversal }
    static var brightAlphaLight: Color { .brightAlphaLight }
    static var brightAlphaLightUniversal: Color { .brightAlphaLightUniversal }
    static var brightAlphaRegular: Color { .brightAlphaRegular }
    static var brightAlphaRegularUniversal: Color { .brightAlphaRegularUniversal }
    static var brightUniversal: Color { .brightUniversal }
    static var brown100: Color { .brown100 }
    static var brown200: Color { .brown200 }
    static var brown300: Color { .brown300 }
    static var brown400: Color { .brown400 }
    static var brown50: Color { .brown50 }
    static var brown500: Color { .brown500 }
    static var brown600: Color { .brown600 }
    static var brown700: Color { .brown700 }
    static var brown800: Color { .brown800 }
    static var brown850: Color { .brown850 }
    static var brown900: Color { .brown900 }
    static var brown950: Color { .brown950 }
    static var dim: Color { .dim }
    static var dimAlphaBold: Color { .dimAlphaBold }
    static var dimAlphaBoldUniversal: Color { .dimAlphaBoldUniversal }
    static var dimAlphaLight: Color { .dimAlphaLight }
    static var dimAlphaLightUniversal: Color { .dimAlphaLightUniversal }
    static var dimAlphaPaleUniversal: Color { .dimAlphaPaleUniversal }
    static var dimAlphaRegular: Color { .dimAlphaRegular }
    static var dimAlphaRegularUniversal: Color { .dimAlphaRegularUniversal }
    static var dimUniversal: Color { .dimUniversal }
    static var disabled: Color { .disabled }
    static var gray100: Color { .gray100 }
    static var gray200: Color { .gray200 }
    static var gray300: Color { .gray300 }
    static var gray400: Color { .gray400 }
    static var gray50: Color { .gray50 }
    static var gray500: Color { .gray500 }
    static var gray600: Color { .gray600 }
    static var gray700: Color { .gray700 }
    static var gray800: Color { .gray800 }
    static var gray850: Color { .gray850 }
    static var gray900: Color { .gray900 }
    static var gray950: Color { .gray950 }
    static var green100: Color { .green100 }
    static var green200: Color { .green200 }
    static var green300: Color { .green300 }
    static var green400: Color { .green400 }
    static var green50: Color { .green50 }
    static var green500: Color { .green500 }
    static var green600: Color { .green600 }
    static var green700: Color { .green700 }
    static var green800: Color { .green800 }
    static var green850: Color { .green850 }
    static var green900: Color { .green900 }
    static var green950: Color { .green950 }
    static var kakao: Color { .kakao }
    static var kakaoYellow100: Color { .kakaoYellow100 }
    static var kakaoYellow200: Color { .kakaoYellow200 }
    static var kakaoYellow300: Color { .kakaoYellow300 }
    static var kakaoYellow400: Color { .kakaoYellow400 }
    static var kakaoYellow50: Color { .kakaoYellow50 }
    static var kakaoYellow500: Color { .kakaoYellow500 }
    static var kakaoYellow600: Color { .kakaoYellow600 }
    static var kakaoYellow700: Color { .kakaoYellow700 }
    static var kakaoYellow800: Color { .kakaoYellow800 }
    static var kakaoYellow850: Color { .kakaoYellow850 }
    static var kakaoYellow900: Color { .kakaoYellow900 }
    static var kakaoYellow950: Color { .kakaoYellow950 }
    static var line1: Color { .line1 }
    static var line2: Color { .line2 }
    static var mainComplete: Color { .mainComplete }
    static var mainCompleteContainer: Color { .mainCompleteContainer }
    static var mainDanger: Color { .mainDanger }
    static var mainDangerContainer: Color { .mainDangerContainer }
    static var mainPrimary: Color { .mainPrimary }
    static var mainPrimaryContainer: Color { .mainPrimaryContainer }
    static var mainSecondary: Color { .mainSecondary }
    static var mainSecondaryContainer: Color { .mainSecondaryContainer }
    static var mainTertiary: Color { .mainTertiary }
    static var mainTertiaryContainer: Color { .mainTertiaryContainer }
    static var members: Color { .members }
    static var mint100: Color { .mint100 }
    static var mint200: Color { .mint200 }
    static var mint300: Color { .mint300 }
    static var mint400: Color { .mint400 }
    static var mint50: Color { .mint50 }
    static var mint500: Color { .mint500 }
    static var mint600: Color { .mint600 }
    static var mint700: Color { .mint700 }
    static var mint800: Color { .mint800 }
    static var mint850: Color { .mint850 }
    static var mint900: Color { .mint900 }
    static var mint950: Color { .mint950 }
    static var orange100: Color { .orange100 }
    static var orange200: Color { .orange200 }
    static var orange300: Color { .orange300 }
    static var orange400: Color { .orange400 }
    static var orange50: Color { .orange50 }
    static var orange500: Color { .orange500 }
    static var orange600: Color { .orange600 }
    static var orange700: Color { .orange700 }
    static var orange800: Color { .orange800 }
    static var orange850: Color { .orange850 }
    static var orange900: Color { .orange900 }
    static var orange950: Color { .orange950 }
    static var point1: Color { .point1 }
    static var point2: Color { .point2 }
    static var purple100: Color { .purple100 }
    static var purple200: Color { .purple200 }
    static var purple300: Color { .purple300 }
    static var purple400: Color { .purple400 }
    static var purple50: Color { .purple50 }
    static var purple500: Color { .purple500 }
    static var purple600: Color { .purple600 }
    static var purple700: Color { .purple700 }
    static var purple800: Color { .purple800 }
    static var purple850: Color { .purple850 }
    static var purple900: Color { .purple900 }
    static var purple950: Color { .purple950 }
    static var red100: Color { .red100 }
    static var red200: Color { .red200 }
    static var red300: Color { .red300 }
    static var red400: Color { .red400 }
    static var red50: Color { .red50 }
    static var red500: Color { .red500 }
    static var red600: Color { .red600 }
    static var red700: Color { .red700 }
    static var red800: Color { .red800 }
    static var red850: Color { .red850 }
    static var red900: Color { .red900 }
    static var red950: Color { .red950 }
    static var textInverse: Color { .textInverse }
    static var textInverseUniversal: Color { .textInverseUniversal }
    static var textPrimary: Color { .textPrimary }
    static var textQuaternary: Color { .textQuaternary }
    static var textSecondary: Color { .textSecondary }
    static var textTertiary: Color { .textTertiary }
    static var violet100: Color { .violet100 }
    static var violet200: Color { .violet200 }
    static var violet300: Color { .violet300 }
    static var violet400: Color { .violet400 }
    static var violet50: Color { .violet50 }
    static var violet500: Color { .violet500 }
    static var violet600: Color { .violet600 }
    static var violet700: Color { .violet700 }
    static var violet800: Color { .violet800 }
    static var violet850: Color { .violet850 }
    static var violet900: Color { .violet900 }
    static var violet950: Color { .violet950 }
    static var vip: Color { .vip }
    static var vvip: Color { .vvip }
    static var whiteAlphaBold: Color { .whiteAlphaBold }
    static var whiteAlphaBoldUniversal: Color { .whiteAlphaBoldUniversal }
    static var whiteAlphaLight: Color { .whiteAlphaLight }
    static var whiteAlphaLightUniversal: Color { .whiteAlphaLightUniversal }
    static var whiteAlphaRegular: Color { .whiteAlphaRegular }
    static var whiteAlphaRegularUniversal: Color { .whiteAlphaRegularUniversal }
    static var whiteInverse: Color { .whiteInverse }
    static var whiteMain: Color { .whiteMain }
    static var whiteUniversal: Color { .whiteUniversal }
    static var yellow100: Color { .yellow100 }
    static var yellow200: Color { .yellow200 }
    static var yellow300: Color { .yellow300 }
    static var yellow400: Color { .yellow400 }
    static var yellow50: Color { .yellow50 }
    static var yellow500: Color { .yellow500 }
    static var yellow600: Color { .yellow600 }
    static var yellow700: Color { .yellow700 }
    static var yellow800: Color { .yellow800 }
    static var yellow850: Color { .yellow850 }
    static var yellow900: Color { .yellow900 }
    static var yellow950: Color { .yellow950 }
}
