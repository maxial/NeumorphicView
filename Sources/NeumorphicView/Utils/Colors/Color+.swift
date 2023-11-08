//
//  Color+.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

extension Color {
    var hex: String? { RGBA(color: self)?.hex }
    
    init?(hex: String) {
        self = RGBA(hex: hex).color
    }
    
    func multiplyBrightness(by value: CGFloat) -> Color {
        var hsba = HSBA(color: self)
        return hsba?.multiplyBrightness(by: value).color ?? self
    }
    
    func addBrightness(value: CGFloat) -> Color {
        var hsba = HSBA(color: self)
        return hsba?.addBrightness(value: value).color ?? self
    }
    
    static func blend(colors: [Color], intensities: [CGFloat]) -> Color? {
        return RGBA.blend(rgbas: colors.compactMap { RGBA(color: $0) }, intensities: intensities)
    }
    
    func getLightColor(intensity: CGFloat) -> Color {
        return self.addBrightness(value: intensity)
    }
    
    func getShadowColor(intensity: CGFloat) -> Color {
        return self.addBrightness(value: -intensity)
    }
}
