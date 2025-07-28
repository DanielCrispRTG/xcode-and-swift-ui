//
//  SwiftUIExtensions.swift
//  SwiftUIStarter
//
//  Created by Shakeeb M on 13/12/19.
//  Copyright © 2019 Shakeeb M. All rights reserved.
//

import SwiftUI

extension Color {
    private static let ColorGray = 0xa5a5a5
    private static let ColorWhite = 0xffffff
    private static let ColorBlack = 0x000000
    private static let ColorBlueBlack = 0x141B26
    private static let ColorLightGray = 0x979797
    private static let ColorConversationGray = 0xF8F8F8
    private static let ColorBlue = 0x0645a2
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
    static var BMBlack : Color {
        return Color(hex: Color.ColorBlack)
    }
    static var BMBlue : Color {
        return Color(hex: Color.ColorBlue)
    }
    static var BMGray : Color {
        return Color(hex: Color.ColorGray)
    }
    static var BMConversationGray : Color {
        return Color(hex: Color.ColorConversationGray)
    }
    static var BMBlueBlack : Color {
        return Color(hex: Color.ColorBlueBlack)
    }
    var uiColor : UIColor {
        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
    
}

extension Font {
    enum BMAvenirWeight : String {
        case black = "Black"
        case medium = "Medium"
        case book = "Book"
        case heavy = "Heavy"
        case light = "Light"
    }
    
    static func Avenir(weight : Font.BMAvenirWeight,size : CGFloat) -> Font {
        return .custom("Avenir-\(weight.rawValue)", size: size)
    }
}
