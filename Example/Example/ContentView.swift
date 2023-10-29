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
            .tint(.black)
            .frame(width: 40, height: 40)
            .roundedNeuShadow(
                cornerRadius: 10,
                state: .inout,
                mainColor: Color(red: 0.9, green: 0.9, blue: 0.9),
                shadowRadius: 2,
                depth: 0.4,
                padding: 2
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
