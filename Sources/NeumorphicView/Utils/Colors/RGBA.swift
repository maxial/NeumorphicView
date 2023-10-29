//
//  RGBA.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

struct RGBA: ColorModel {
    private enum Constants {
        static let rbgComponentsCount = 3
        static let rbgaComponentsCount = 4
        static let rgbHexLength = 6
        static let rgbaHexLength = 8
        static let hexFormat = "%02lX%02lX%02lX%02lX"
    }
    
    private let r: CGFloat
    private let g: CGFloat
    private let b: CGFloat
    private let a: CGFloat
    
    var color: Color { getColor() }
    var hex: String { getHex() }
    
    init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    
    init(hex: String) {
        let pureHex = RGBA.clear(hex: hex)
        let intHex = RGBA.getIntHex(from: pureHex)
        
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero, .zero)
        
        if pureHex.count == Constants.rgbHexLength {
            (r, g, b, a) = (
                CGFloat((intHex & 0xFF0000) >> 16) / 255.0,
                CGFloat((intHex & 0x00FF00) >> 8) / 255.0,
                CGFloat(intHex & 0x0000FF) / 255.0,
                1
            )
        } else if pureHex.count == Constants.rgbaHexLength {
            (r, g, b, a) = (
                CGFloat((intHex & 0xFF000000) >> 24) / 255.0,
                CGFloat((intHex & 0x00FF0000) >> 16) / 255.0,
                CGFloat((intHex & 0x0000FF00) >> 8) / 255.0,
                CGFloat(intHex & 0x000000FF) / 255.0
            )
        }
        
        self.init(r: r, g: g, b: b, a: a)
    }
    
    init?(color: Color) {
        let uiColor = UIColor(color)
        guard
            let components = uiColor.cgColor.components,
            components.count == Constants.rbgComponentsCount || components.count == Constants.rbgaComponentsCount
        else {
            return nil
        }
        
        self.init(
            r: components[0],
            g: components[1],
            b: components[2],
            a: components.count == Constants.rbgaComponentsCount ? components[3] : 1
        )
    }
    
    static func blend(rgbas: [RGBA], intensities: [CGFloat]) -> Color? {
        guard rgbas.count > 1, rgbas.count == intensities.count else {
            return rgbas.first?.color
        }
        
        let rgbaConfigs = zip(rgbas, intensities)
        
        var (r, g, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero, .zero)
        for rgbaConfig in rgbaConfigs {
            (r, g, b, a) = (
                r + rgbaConfig.0.r * rgbaConfig.1,
                g + rgbaConfig.0.g * rgbaConfig.1,
                b + rgbaConfig.0.b * rgbaConfig.1,
                a + rgbaConfig.0.a * rgbaConfig.1
            )
        }
        
        return Color(
            red: max(.zero, min(r, 1)),
            green: max(.zero, min(g, 1)),
            blue: max(.zero, min(b, 1)),
            opacity: max(.zero, min(a, 1))
        )
    }
    
    private func getColor() -> Color {
        return Color(red: r, green: g, blue: b, opacity: a)
    }
    
    private func getHex() -> String {
        return String(
            format: Constants.hexFormat,
            lroundf(Float(r) * 255.0),
            lroundf(Float(g) * 255.0),
            lroundf(Float(b) * 255.0),
            lroundf(Float(a) * 255.0)
        )
    }
    
    private static func clear(hex: String) -> String {
        return hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: String.colorMark, with: String.empty)
    }
    
    private static func getIntHex(from hex: String) -> UInt64 {
        var hexInt: UInt64 = .zero
        Scanner(string: hex).scanHexInt64(&hexInt)
        return hexInt
    }
}
