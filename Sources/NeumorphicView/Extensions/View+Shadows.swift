//
//  View+Shadows.swift
//
//
//  Created by Maxim Aliev on 24.10.2023.
//

import SwiftUI

extension View {
    public func neuShadow<S: Shape>(
        outerShape: S,
        innerShape: S? = nil,
        state: ShadowState = .out,
        mainColor: Color,
        lightColor: Color = .white,
        radius: CGFloat = 4,
        depth: CGFloat = 0.2,
        padding: CGFloat = 3,
        blurIntensity: CGFloat = 0.5
    ) -> some View {
        background(
            GeometryReader { geometry in
                ZStack {
                    if state == .out || state == .inout {
                        outerShape
                            .fill(mainColor)
                            .modifier(
                                ConvexModifier(
                                    lightColor: lightColor,
                                    radius: radius,
                                    depth: depth
                                )
                            )
                            .blur(radius: padding * blurIntensity)
                    }
                    if let innerShape, state == .in || state == .inout {
                        innerShape
                            .fill(mainColor)
                            .modifier(
                                ConcaveModifier(
                                    shape: innerShape,
                                    lightColor: lightColor,
                                    radius: radius,
                                    depth: depth
                                )
                            )
                            .padding(padding)
                            .blur(radius: padding * blurIntensity)
                    }
                }
            }
        )
    }
    
    @ViewBuilder
    public func roundedNeuShadow(
        cornerRadius: CGFloat = 10,
        state: ShadowState = .out,
        mainColor: Color,
        lightColor: Color = .white,
        shadowRadius: CGFloat = 4,
        depth: CGFloat = 0.2,
        padding: CGFloat = 3,
        blurIntensity: CGFloat = 0.5
    ) -> some View {
        neuShadow(
            outerShape: RoundedRectangle(cornerRadius: cornerRadius),
            innerShape: RoundedRectangle(cornerRadius: cornerRadius - padding),
            state: state,
            mainColor: mainColor,
            lightColor: lightColor,
            radius: shadowRadius,
            depth: depth,
            padding: padding,
            blurIntensity: blurIntensity
        )
    }
}
