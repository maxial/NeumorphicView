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
    
    func withBrightness(multiplier: CGFloat) -> Color {
        var hsba = HSBA(color: self)
        return hsba?.withBrightness(multiplier: multiplier).color ?? self
    }
    
    static func blend(colors: [Color], intensities: [CGFloat]) -> Color? {
        return RGBA.blend(rgbas: colors.compactMap { RGBA(color: $0) }, intensities: intensities)
    }
    
    func getShadowColor(depth: CGFloat) -> Color {
        return Color.blend(colors: [self, .black], intensities: [1 - depth, depth]) ?? self
    }
}
