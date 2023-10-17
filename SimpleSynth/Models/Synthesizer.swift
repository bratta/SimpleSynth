//
//  Synthesizer.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/10/23.
//

import Foundation
import AudioKit
import Keyboard
import Tonic
import SoundpipeAudioKit
import Controls

// Defines a simple, 3 oscillator analog style synthesizer
// Note that the number of oscillators can change solely by
// updating the OscillatorData class.
class Synthesizer: ObservableObject {
    // MARK: - Properties
    // This is the actual audio engine
    private let engine = AudioEngine()
   
    // This is the mixer for our oscillators
    lazy var mixer = Mixer(data.oscillators)
    
    // Here's is our nice analog style MoogLadder filter.
    // The Moog filter is known for a certain sound and this does a decent
    // job of emulating that behavior.
    lazy var filter = MoogLadder(mixer, cutoffFrequency: OscillatorData.defaultCutoff, resonance: OscillatorData.defaultResonance)
   
    // MARK: - Published properties
    // Used to control the current octave of the synth's on-screen keyboard
    @Published var octaveOffset = 0
   
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
