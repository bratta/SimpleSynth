//
//  KeyboardView.swift
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

struct KeyboardView: View {
    var octaveOffset = 0
    var octaves = 2
    var noteOn: (Pitch, CGPoint) -> Void = { _, _ in }
    var noteOff: (Pitch) -> Void
    
    var body: some View {
        let range = MIDIHelper.PitchRange(
            from: .C3,
            octaves: octaves,
            octaveOffset: octaveOffset
        )
        Keyboard(
            layout: .piano(pitchRange: range),
            noteOn: noteOn,
            noteOff: noteOff
        ) { pitch, isActivated in
            KeyboardKey(pitch: pitch, isActivated: isActivated, pressedColor: .pink, flatTop: true)
        }.cornerRadius(5)
    }
}

#Preview {
    KeyboardView(
        octaveOffset: 0,
        noteOn: { _, _ in },
        noteOff: { _ in }
    )
}
