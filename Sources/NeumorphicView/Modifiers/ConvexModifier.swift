//
//  ConvexModifier.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

struct ConvexModifier: ViewModifier {
    private let mainColor: Color
    private let radius: CGFloat
    private let intensity: CGFloat
    
    init(mainColor: Color, radius: CGFloat, intensity: CGFloat) {
        self.mainColor = mainColor
        self.radius = radius
        self.intensity = intensity
    }
    
    func body(content: Content) -> some View {
        let lightColor = mainColor.getLightColor(intensity: intensity)
        let shadowColor = mainColor.getShadowColor(intensity: intensity)
        
        content
            .shadow(color: shadowColor, radius: radius, x: radius * 2, y: radius * 2)
            .shadow(color: lightColor, radius: radius, x: -radius * 2, y: -radius * 2)
    }
}
