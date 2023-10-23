//
//  SynthView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/10/23.
//

import SwiftUI
import AudioKit
import Keyboard
import Tonic
import SoundpipeAudioKit
import Controls

struct MIDISynthView: View {
    @StateObject var synthesizer = MIDISynthesizer()
    @StateObject var octave = Octave()
   
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 0) {
                Spacer()
                WaveformView(synthesizer.instrument)
                    .frame(width: 300, height: 200)
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
    MIDISynthView()
}
