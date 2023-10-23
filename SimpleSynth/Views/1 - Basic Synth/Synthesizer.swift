//
//  Synthesizer.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 11/13/23.
//

import Foundation
import AudioKit
import Keyboard
import Tonic
import SoundpipeAudioKit
import Controls
import DunneAudioKit

// Defines a simple, 3 oscillator analog style synthesizer
// Note that the number of oscillators can change solely by
// updating the OscillatorData class.
class Synthesizer: SynthesizerProtocol {
    // MARK: - Properties
    // This is the actual audio engine
    private let engine = AudioEngine()
   
    // This is the mixer for our oscillators
    lazy var mixer = Mixer(data.oscillators)
    
    // Here's is our nice analog style MoogLadder filter.
    // The Moog filter is known for a certain sound and this does a decent
    // job of emulating that behavior.
    lazy var filter = MoogLadder(mixer, cutoffFrequency: OscillatorData.defaultCutoff, resonance: OscillatorData.defaultResonance)
    
    // These aren't used by this version of the SynthesizerProtocol; ignore for now
    @Published var envelope: AmplitudeEnvelope!
    @Published var attack: AUValue = 0.0
    @Published var decay: AUValue = 0.0
    @Published var sustain: AUValue = 1.0
    @Published var release: AUValue = 0.0
   
    // MARK: - Published properties
    // Settings shared across all oscillators
    @Published var data = OscillatorData() {
        didSet {
            if data.isPlaying {
                for i in 0...data.oscillators.count-1 {
                    data.oscillators[i].start()
                    data.oscillators[i].setWaveform(Table(data.waveforms[i]))
                    data.oscillators[i].$amplitude.ramp(to: data.amplitude[i], duration: 0)
                    data.oscillators[i].$frequency.ramp(to: data.frequencies[i], duration: data.rampDuration)
                }
            } else {
                for i in 0...data.oscillators.count-1 {
                    data.oscillators[i].amplitude = 0.0
                }
            }
        }
    }
   
    // The filter's cutoff frequency (Hz)
    // The filter for this is a Moog ladder-style lowpass filter
    // Meaning that it will filter frequencies higher than what is
    // specified by this cutoff value.
    @Published var cutoff = AUValue(20_000) {
        didSet {
            filter.cutoffFrequency = AUValue(cutoff)
        }
    }
   
    // Define the range of valid values for the filter cutoff
    @Published var cutoffRange: ClosedRange<Float> = 12.0 ... 20000.0
   
    // The filter's resonance value
    // This introduces a boost in the frequencies right before the
    // filter's cutoff, resulting in some interesting sounds. It
    // can also "self resonate", causing some sharp and sometimes
    // unlpeasant sounds.
    @Published var resonance = AUValue(0.0) {
        didSet {
            filter.resonance = AUValue(resonance)
        }
    }
   
    // Define the range of valid values for the filter resonance
    @Published var resonanceRange: ClosedRange<Float> = 0.0 ... 0.9
   
    // MARK: - Initializer
    init() {
        // Oscillators -> Mixer -> Filter -> Engine
        engine.output = filter
        try? engine.start()
    }
    
    // MARK: - Public functions
    func noteOn(pitch: Pitch, point: CGPoint) {
        data.isPlaying = true
        for i in 0...data.oscillators.count-1 {
            data.frequencies[i] = AUValue(pitch.midiNoteNumber + data.pitchOffsets[i]).midiNoteToFrequency()
        }
    }
    
    func noteOff(pitch: Pitch) {
        data.isPlaying = false
    }
}
