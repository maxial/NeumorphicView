//
//  ConcaveModifier.swift
//  
//
//  Created by Maxim Aliev on 25.10.2023.
//

import SwiftUI

struct ConcaveModifier<S: Shape>: ViewModifier {
    private let shape: S
    private let lightColor: Color
    private let radius: CGFloat
    
    init(shape: S, lightColor: Color, radius: CGFloat) {
        self.shape = shape
        self.lightColor = lightColor
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(overlay(isLightSide: true))
            .overlay(overlay(isLightSide: false))
            .mask(shape)
    }
    
    @ViewBuilder
    private func overlay(isLightSide: Bool) -> some View {
        let color = isLightSide ? lightColor : lightColor.getShadowColor()
        let sign: CGFloat = isLightSide ? -1 : 1
        
        shape
            .fill(color)
            .inverseMask(shape.offset(CGSize(width: sign * radius * 2, height: sign * radius * 2)))
            .offset(CGSize(width: sign * -radius * 2, height: sign * -radius * 2))
            .shadow(color: color, radius: radius, x: sign * radius, y: sign * radius)
    }
}
