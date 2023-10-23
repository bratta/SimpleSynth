//
//  EnvSynthesizer.swift
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
class EnvSynthesizer: Instrument, SynthesizerProtocol {
    // MARK: - Properties
    // This is the actual audio engine
    private let engine = AudioEngine()
   
    // This is the mixer for our oscillators
    var mixer: Mixer!
    
    // MARK: - Published properties
    
    // Here's is our nice analog style MoogLadder filter.
    // The Moog filter is known for a certain sound and this does a decent
    // job of emulating that behavior.
    @Published var filter: MoogLadder!
    
    // The envelope shapes the sound; in this case we are
    // shaping the amplitude, or volume of the sound whenever
    // a key is pressed. We can later on adjust the values to create
    // sounds that range from plucky to slow, swelling pads
    @Published var envelope: AmplitudeEnvelope!
   
    // Settings shared across all oscillators
    @Published var data = EnvOscillatorData() {
        didSet {
            for i in 0...data.oscillators.count-1 {
                data.oscillators[i].start()
                data.oscillators[i].setWaveform(Table(data.waveforms[i]))
                data.oscillators[i].$amplitude.ramp(to: data.amplitude[i], duration: 0)
                data.oscillators[i].$frequency.ramp(to: data.frequencies[i], duration: data.rampDuration)
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
    
    // Amplitude Envelope settings
    @Published var attack = AUValue(0.0) {
        didSet {
            envelope.attackDuration = AUValue(attack)
        }
    }
    
    @Published var decay = AUValue(0.0) {
        didSet {
            envelope.decayDuration = AUValue(decay)
        }
    }
    
    @Published var sustain = AUValue(1.0) {
        didSet {
            envelope.sustainLevel = AUValue(sustain)
        }
    }
    
    @Published var release = AUValue(0.0) {
        didSet {
            envelope.releaseDuration = AUValue(release)
        }
    }
    
    // Define the range of valid values for the filter resonance
    @Published var resonanceRange: ClosedRange<Float> = 0.0 ... 0.9
   
    // MARK: - Initializer
    override init() {
        // Here we will basically use lazy initialization to get everything rolling
        // straight from the initializer. This is mainly because of how we're using
        // the OscillatorData class to do a lot of heavy lifting and we need it
        // to be initialized, published, AND utilize a didSet--all from the init()
        // method. This is stretching Swift a bit and it might be better to refactor
        // the OscillatorData class to keep this from being necessary.
        super.init()
        defer { setupAudioEngine() }
    }
    
    // MARK: - Public functions
    func noteOn(pitch: Pitch, point: CGPoint) {
        for i in 0...data.oscillators.count-1 {
            data.frequencies[i] = AUValue(pitch.midiNoteNumber + data.pitchOffsets[i]).midiNoteToFrequency()
        }
        // A slight delay is needed so the envelope opening event is not ignored
        // in cases of rapid key presses
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            // We're no longer using the "isPlaying" boolean, but instead allowing
            // the amplitude envelope to control the sound coming from the oscillators
            self.envelope.openGate()
        }
    }
    
    func noteOff(pitch: Pitch) {
        // Again, we're using the amplitude envelope to control the sound
        // as opposed to the "isPlaying" boolean.
        envelope.closeGate()
    }
   
    // MARK: - Private functions
    // This method refactors the initialization out of
    // a bunch of lazy vars to a more deferred instantiation.
    private func setupAudioEngine() {
        mixer = Mixer(data.oscillators)
        filter = MoogLadder(mixer, cutoffFrequency: OscillatorData.defaultCutoff, resonance: OscillatorData.defaultResonance)
        envelope = AmplitudeEnvelope(
            filter,
            attackDuration: 0.0,
            decayDuration: 1.0,
            sustainLevel: 0.0,
            releaseDuration: 0.25
        )
      
        // Oscillators -> Mixer -> Filter -> Amp. Envelope -> Engine
        engine.output = envelope
        try? engine.start()
    }
}
