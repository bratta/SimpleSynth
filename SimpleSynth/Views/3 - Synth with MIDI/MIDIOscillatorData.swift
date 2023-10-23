//
//  MIDIOscillatorData.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/10/23.
//

import Foundation
import AudioKit
import SoundpipeAudioKit

// This class assumes a finite number of oscillators. Three is a good choice
// as it is a number often used by hardware/software synthesizers to achieve
// a wide pallate of different sounds with subtractive synthesis.
struct MIDIOscillatorData {
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
    static let defaultAmplitude: AUValue = 0.2
    static let maxPitchBendRange: UInt8 = 12
    
    // MARK: - Oscillator Pitches
    // Holds the initial and ongoing pitch value for each oscillator (Hz)
    var frequencies: [AUValue] = [ 440, 440, 440 ]
    
    // MARK: - Oscillator Waveforms
    // This sets the basic shapes for the waveforms
    // Using values such as sawtooth, triangle, square, sine, etc.
    var waveforms: [TableType] = [
        MIDIOscillatorData.defaultTableTypes[0],
        MIDIOscillatorData.defaultTableTypes[1],
        MIDIOscillatorData.defaultTableTypes[2]
    ]
    
    // MARK: - Pitch Offsets
    // This allows you to change the pitch of the note when played,
    // verses the actual note that is struck. This value is in semitones.
    // This default sets the third oscillator as the "sub oscillator"
    var pitchOffsets: [Int8] = [ 0, 0, -12 ]
   
    // MARK: - Oscillator amplitudes
    // Amplitude is loudness. It is controlled per oscillator
    // instead of at the mixer level like you'd typically think
    var amplitude: [AUValue] = [ defaultAmplitude, defaultAmplitude, defaultAmplitude ]
    
    // MARK - Oscillators
    // This is the array of oscillators used by the synthesizer
    var oscillators : [DynamicOscillator] = [
        DynamicOscillator(waveform: Table(MIDIOscillatorData.defaultTableTypes[0]), detuningOffset: MIDIOscillatorData.defaultDetuningOffsets[0]),
        DynamicOscillator(waveform: Table(MIDIOscillatorData.defaultTableTypes[1]), detuningOffset: MIDIOscillatorData.defaultDetuningOffsets[1]),
        DynamicOscillator(waveform: Table(MIDIOscillatorData.defaultTableTypes[2]), detuningOffset: MIDIOscillatorData.defaultDetuningOffsets[2])
    ]
    
    // MARK: - Other settings
    // Ramp speed between notes
    // This is known as glide or portamento
    var rampDuration: AUValue = 0.0
}
