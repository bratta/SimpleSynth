//
//  OscillatorData.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 11/13/23.
//

import Foundation
import AudioKit
import SoundpipeAudioKit

// This class assumes a finite number of oscillators. Three is a good choice
// as it is a number often used by hardware/software synthesizers to achieve
// a wide pallate of different sounds with subtractive synthesis.
struct OscillatorData {
    // MARK: - Default Settings
    // Define the defaults for our oscillator waveforms
    // as well as give callers the ability to change the
    // waveform as needed.
    static let defaultTableTypes: [TableType] = [ .sawtooth, .sawtooth, .sine ]
    static let defaultDetuningOffsets: [AUValue] = [ -0.5, 0.5, 0 ]
    // Default filter cutoff frequency (Hz)
    static let defaultCutoff: Float = 20_000
    // Default filter resonance (0.0 ... 1.0)
    static let defaultResonance: Float = 0.0
    
    // MARK: - Oscillator Pitches
    // Holds the initial and ongoing pitch value for each oscillator (Hz)
    var frequencies: [AUValue] = [ 440, 440, 440 ]
    
    // MARK: - Oscillator Waveforms
    // This sets the basic shapes for the waveforms
    // Using values such as sawtooth, triangle, square, sine, etc.
    var waveforms: [TableType] = [
        OscillatorData.defaultTableTypes[0],
        OscillatorData.defaultTableTypes[1],
        OscillatorData.defaultTableTypes[2]
    ]
    
    // MARK: - Pitch Offsets
    // This allows you to change the pitch of the note when played,
    // verses the actual note that is struck. This value is in semitones.
    // This default sets the third oscillator as the "sub oscillator"
    var pitchOffsets: [Int8] = [ 0, 0, -12 ]
   
    // MARK: - Oscillator amplitudes
    // Amplitude is loudness. It is controlled per oscillator
    // instead of at the mixer level like you'd typically think
    var amplitude: [AUValue] = [ 0.2, 0.2, 0.2 ]
    
    // MARK - Oscillators
    // This is the array of oscillators used by the synthesizer
    var oscillators : [DynamicOscillator] = [
        DynamicOscillator(waveform: Table(OscillatorData.defaultTableTypes[0]), detuningOffset: OscillatorData.defaultDetuningOffsets[0]),
        DynamicOscillator(waveform: Table(OscillatorData.defaultTableTypes[1]), detuningOffset: OscillatorData.defaultDetuningOffsets[1]),
        DynamicOscillator(waveform: Table(OscillatorData.defaultTableTypes[2]), detuningOffset: OscillatorData.defaultDetuningOffsets[2])
    ]
    
    // MARK: - Other settings
    // Is the engine playing any sound?
    var isPlaying: Bool = false
    
    // Ramp speed between notes
    // This is known as glide or portamento
    var rampDuration: AUValue = 0.0
}
