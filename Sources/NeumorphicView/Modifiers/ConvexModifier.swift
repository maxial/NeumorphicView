//
//  ConvexModifier.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

struct ConvexModifier: ViewModifier {
    private let lightColor: Color
    private let radius: CGFloat
    
    init(lightColor: Color, radius: CGFloat) {
        self.lightColor = lightColor
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .shadow(color: lightColor.getShadowColor(), radius: radius, x: radius * 2, y: radius * 2)
            .shadow(color: lightColor, radius: radius, x: -radius * 2, y: -radius * 2)
    }
}