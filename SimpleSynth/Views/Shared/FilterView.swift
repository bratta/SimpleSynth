//
//  FilterView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/17/23.
//

import SwiftUI
import Controls

struct FilterView<SP: SynthesizerProtocol>: View {
    @StateObject var synthesizer: SP
    
    var body: some View {
        VStack {
            Text("Lowpass Filter")
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(0)
            HStack {
                VStack {
                    ArcKnob("CTF", value: $synthesizer.cutoff, range: synthesizer.cutoffRange)
                        .foregroundColor(.white)
                        .frame(maxWidth: 75, maxHeight: 75)
                        .padding(.bottom, 5)
                }
                .padding(.trailing, 10)
                VStack {
                    ArcKnob("RES", value: $synthesizer.resonance, range: synthesizer.resonanceRange)
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
    FilterView(synthesizer: EnvSynthesizer())
}
