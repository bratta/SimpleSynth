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

struct SynthView: View {
    @StateObject var synthesizer = Synthesizer()
   
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 0) {
                Spacer()
                FilterView(synthesizer: synthesizer)
                    .padding(.bottom, 10)
                OctaveView(synthesizer: synthesizer)
                KeyboardView(
                    octaveOffset: synthesizer.octaveOffset,
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
    SynthView()
}
