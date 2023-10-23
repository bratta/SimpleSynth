//
//  SynthesizerProtocol.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 11/13/23.
//

import Foundation
import AudioKit
import Tonic
import DunneAudioKit
import SoundpipeAudioKit

// Setting up this protocol like an interface, to be able
// to pass around various versions of the Synthesizer object
// to the different views without having to re-invent the wheel
// each time we want to instantiate them.
protocol SynthesizerProtocol: ObservableObject {
    // Filter settings
    var cutoff: AUValue { get set }
    var resonance: AUValue { get set }
    var cutoffRange: ClosedRange<Float> { get set }
    var resonanceRange: ClosedRange<Float> { get set }
    
    // Quick and dirty: These will be setup by all instances of this
    // protocol, but really it will only be used by a subset of
    // implementations
    var envelope: AmplitudeEnvelope! { get set }
   
    // Amplitude Envelope
    var attack: AUValue { get set }
    var decay: AUValue { get set }
    var sustain: AUValue { get set }
    var release: AUValue { get set }

    // Functions that make or stop sound; used by all implementations
    func noteOn(pitch: Pitch, point: CGPoint)
    func noteOff(pitch: Pitch)
}
