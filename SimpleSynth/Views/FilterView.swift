//
//  FilterView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/17/23.
//

import SwiftUI
import Controls

struct FilterView: View {
    @StateObject var synthesizer: Synthesizer
    
    var body: some View {
        VStack {
            Text("Lowpass Filter")
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(0)
            HStack {
                VStack {
                    ArcKnob("CTF", value: $synthesizer.cutoff, range: 12.0...20_000)
                        .foregroundColor(.white)
                        .frame(maxWidth: 75, maxHeight: 75)
                        .padding(.bottom, 5)
                }
                .padding(.trailing, 10)
                VStack {
                    ArcKnob("RES", value: $synthesizer.resonance, range: 0.0...0.9)
                        .foregroundColor(.white)
                        .frame(maxWidth: 75, maxHeight: 75)
                        .padding(.bottom, 5)
                }
                .padding(.leading, 10)
            }
            .padding(0)
        }
        .frame(maxWidth: 150)
        .padding(5)
        .background(.green)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
        )
    }
}

#Preview {
    FilterView(synthesizer: Synthesizer())
}
