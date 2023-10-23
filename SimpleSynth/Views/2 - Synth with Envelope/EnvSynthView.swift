//
//  EnvSynthView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 11/13/23.
//

import SwiftUI
import AudioKit
import Keyboard
import Tonic
import SoundpipeAudioKit
import Controls

struct EnvSynthView<SP: SynthesizerProtocol>: View {
    @StateObject var synthesizer: SP
    @StateObject var octave = Octave()
   
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 0) {
                Spacer()
                WaveformView(synthesizer.envelope)
                    .frame(width: 300, height: 200)
                    .padding(.bottom, 10)
                AmpEnvelopeView(synthesizer: synthesizer)
                    .padding(.bottom, 10)
                FilterView(synthesizer: synthesizer)
                    .padding(.bottom, 10)
                OctaveView(octave: octave)
                KeyboardView(
                    octaveOffset: octave.offset,
                    noteOn: synthesizer.noteOn(pitch:point:),
                    noteOff: synthesizer.noteOff
                )
                .padding(.top, 0)
                .frame(maxHeight: 200)
            }
        }
    }
}

#Preview {
    EnvSynthView(synthesizer: EnvSynthesizer())
}
