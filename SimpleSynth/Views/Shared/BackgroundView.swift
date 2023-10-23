//
//  BackgroundView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/10/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        RadialGradient(
            gradient: Gradient(
                colors: [
                .green.opacity(0.5), .black
                ]
            ), center: .center, startRadius: 2, endRadius: 650
        )
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BackgroundView()
}
