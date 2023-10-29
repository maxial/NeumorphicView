//
//  ContentView.swift
//  Example
//
//  Created by Maxim Aliev on 26.10.2023.
//

import SwiftUI
import NeumorphicView

struct ContentView: View {
    var body: some View {
        ZStack {
            Button("Click Me") {
                print("Tap")
            }
            .tint(.black)
            .frame(width: 200, height: 100)
            .roundedNeuShadow(
                cornerRadius: 20,
                state: .inout,
                mainColor: Color(red: 0.9, green: 0.9, blue: 0.9),
                padding: 3
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
    }
}

#Preview {
    ContentView()
}
