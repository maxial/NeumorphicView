//
//  HSBA.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

struct HSBA: ColorModel {
    private var h: CGFloat
    private var s: CGFloat
    private var b: CGFloat
    private var a: CGFloat
    
    var color: Color { getColor() }
    
    init(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        self.h = h
        self.s = s
        self.b = b
        self.a = a
    }
    
    init?(color: Color) {
        let uiColor = UIColor(color)
        
        var (h, s, b, a): (CGFloat, CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero, .zero)
        
        guard uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return nil }
        
        self.init(h: h, s: s, b: b, a: a)
    }
    
    mutating func withBrightness(multiplier: CGFloat) -> HSBA {
        self.b *= multiplier
        return self
    }
    
    private func getColor() -> Color {
        return Color(hue: h, saturation: s, brightness: b, opacity: a)
    }
}
