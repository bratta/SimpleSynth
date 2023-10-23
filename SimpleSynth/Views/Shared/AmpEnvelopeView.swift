//
//  AmpEnvelopeView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/23/23.
//

import SwiftUI
import Controls

struct AmpEnvelopeView<SP: SynthesizerProtocol>: View {
    @StateObject var synthesizer: SP
    
    var body: some View {
        VStack {
            Text("Amplitude Envelope")
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity)
                .background(.white)
                .padding(0)
            HStack {
                VStack {
                    ArcKnob("ATK", value: $synthesizer.attack, range: 0.0...10.0)
                        .foregroundColor(.white)
                        .frame(maxWidth: 60, maxHeight: 60)
                        .padding(.bottom, 5)
                }
                VStack {
                    ArcKnob("DEC", value: $synthesizer.decay, range: 0.0...10.0)
                        .foregroundColor(.white)
                        .frame(maxWidth: 60, maxHeight: 60)
                        .padding(.bottom, 5)
                }
                VStack {
                    ArcKnob("SUS", value: $synthesizer.sustain, range: 0.0...1.0)
                        .foregroundColor(.white)
                        .frame(maxWidth: 60, maxHeight: 60)
                        .padding(.bottom, 5)
                }
                VStack {
                    ArcKnob("REL", value: $synthesizer.release, range: 0.0...10.0)
                        .foregroundColor(.white)
                        .frame(maxWidth: 60, maxHeight: 60)
                        .padding(.bottom, 5)
                }
            }
            .padding(0)
        }
        .frame(maxWidth: 300)
        .padding(5)
        .background(.green)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
        )    }
}

#Preview {
    AmpEnvelopeView(synthesizer: EnvSynthesizer())
}
