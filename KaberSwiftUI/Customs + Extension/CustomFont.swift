//
//  CustomFont.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

enum Fonts: String {
    case thin = "Poppins-Thin"
    case semiBold = "Poppins-SemiBold"
    case italic = "Poppins-Italic"
    case mediumItalic = "Poppins-MediumItalic"
    case regular = "Poppins-Regular"
    case blackItalic = "Poppins-BlackItalic"
    case lightItalic = "Poppins-LightItalic"
    case bold = "Poppins-Bold"
    case black = "Poppins-Black"
    case thinItalic = "Poppins-ThinItalic"
    case extraLightItalic = "Poppins-ExtraLightItalic"
    case boldItalic = "Poppins-BoldItalic"
    case light = "Poppins-Light"
    case medium = "Poppins-Medium"
    case semiBoldItalic = "Poppins-SemiBoldItalic"
    case extraBoldItalic = "Poppins-ExtraBoldItalic"
    case extraBold = "Poppins-ExtraBold"
    case extraLight = "Poppins-ExtraLight"
}

struct CustomFontModifier: ViewModifier {
    var fontName: Fonts
    var size: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.custom(fontName.rawValue, size: size))
    }
}

extension View {
    
    func setFont(fontName: Fonts, size: CGFloat) -> some View {
        self.modifier(CustomFontModifier(fontName: fontName, size: size))
    }
}
