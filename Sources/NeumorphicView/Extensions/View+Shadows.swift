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
        shadowRadius: CGFloat = 4,
        padding: CGFloat = 3,
        lightIntensity: CGFloat = 0.2,
        blurIntensity: CGFloat = 0.4
    ) -> some View {
        background(
            GeometryReader { geometry in
                ZStack {
                    if state == .out || state == .inout {
                        outerShape
                            .fill(mainColor)
                            .modifier(
                                ConvexModifier(
                                    mainColor: mainColor,
                                    radius: shadowRadius,
                                    intensity: lightIntensity
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
                                    mainColor: mainColor,
                                    radius: shadowRadius,
                                    intensity: lightIntensity
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
        shadowRadius: CGFloat = 4,
        padding: CGFloat = 3,
        lightIntensity: CGFloat = 0.2,
        blurIntensity: CGFloat = 0.4
    ) -> some View {
        let outerShape = RoundedRectangle(cornerRadius: cornerRadius)
        let innerShape = RoundedRectangle(cornerRadius: cornerRadius - padding)
        
        self
            .clipShape(outerShape)
            .neuShadow(
                outerShape: outerShape,
                innerShape: innerShape,
                state: state,
                mainColor: mainColor,
                shadowRadius: shadowRadius,
                padding: padding,
                lightIntensity: lightIntensity,
                blurIntensity: blurIntensity
        )
    }
}
