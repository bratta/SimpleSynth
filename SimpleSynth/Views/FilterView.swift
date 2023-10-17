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
                .padding(0)
            HStack {
                VStack {
                    Text("Cutoff")
                        .padding(.top, 10)
                    SmallKnob(value: $synthesizer.cutoff, range: 12.0...20_000)
                        .frame(maxWidth: 50)
                        .padding(.bottom, 10)
                }
                .padding(.trailing, 10)
                VStack {
                    Text("Resonance")
                        .padding(.top, 10)
                    SmallKnob(value: $synthesizer.resonance, range: 0.0...0.9)
                        .frame(maxWidth: 50)
                        .padding(.bottom, 10)
                }
                .padding(.leading, 10)
            }
            .padding(0)
        }
        .padding()
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
