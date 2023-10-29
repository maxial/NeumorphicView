//
//  View+Helpers.swift
//
//
//  Created by Maxim Aliev on 29.10.2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
        self.mask {
            mask
                .foregroundColor(.black)
                .background(Color.white)
                .compositingGroup()
                .luminanceToAlpha()
        }
    }
}
