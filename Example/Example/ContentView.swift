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
            Button("Me") {
                print("Tap")
            }
            .tint(.white)
            .frame(width: 100, height: 40)
            .roundedNeuShadow(
                cornerRadius: 10,
                state: .inout,
                mainColor: Color(red: 0.1, green: 0.1, blue: 0.1),
                shadowRadius: 2,
                padding: 2,
                lightIntensity: 0.2
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.1, green: 0.1, blue: 0.1))
    }
}

#Preview {
    ContentView()
}
