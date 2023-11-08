//
//  ConcaveModifier.swift
//  
//
//  Created by Maxim Aliev on 25.10.2023.
//

import SwiftUI

struct ConcaveModifier<S: Shape>: ViewModifier {
    private let shape: S
    private let mainColor: Color
    private let radius: CGFloat
    private let intensity: CGFloat
    
    init(shape: S, mainColor: Color, radius: CGFloat, intensity: CGFloat) {
        self.shape = shape
        self.mainColor = mainColor
        self.radius = radius
        self.intensity = intensity
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(overlay(color: mainColor.getLightColor(intensity: intensity), offset: -1))
            .overlay(overlay(color: mainColor.getShadowColor(intensity: intensity), offset: 1))
            .mask(shape)
    }
    
    private func overlay(color: Color, offset: CGFloat) -> some View {
        shape
            .fill(color)
            .inverseMask(shape.offset(CGSize(width: offset * radius * 2, height: offset * radius * 2)))
            .offset(CGSize(width: offset * -radius * 2, height: offset * -radius * 2))
            .shadow(color: color, radius: radius, x: offset * radius, y: offset * radius)
    }
}
