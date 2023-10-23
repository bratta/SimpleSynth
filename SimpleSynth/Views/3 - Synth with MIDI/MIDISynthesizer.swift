//
//  MIDISynthesizer.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/10/23.
//

import Foundation
import AudioKit
import AudioKitEX
import Keyboard
import Tonic
import SoundpipeAudioKit
import Controls
import DunneAudioKit

// Defines a simple, 3 oscillator analog style synthesizer
// Note that the number of oscillators can change solely by
// updating the OscillatorData class.
class MIDISynthesizer: ObservableObject {
    // MARK: - Properties
    // This is the actual audio engine
    private let engine = AudioEngine()
   
    // We need this to establish a MIDI connection
    private let midi = MIDI()
    
    // MARK: - Published properties
    @Published var instrument = MIDISampler(name: "Instrument 1")
    
    // MARK: - Initializer
    init(name midiOutputName: String? = nil) {
        // Listen for MIDI messages
        midi.addListener(self)
        engine.output = instrument
        
        do {
            // This sampled instrument was created in Logic Pro, sampled from my Hydrasynth Deluxe
            // with the "Suitcase MK2 RA" preset
            if let sampleURL = Bundle.main.url(forResource: "Samples/hydrasynth_mk2", withExtension: "exs") {
                try instrument.loadInstrument(url: sampleURL)
            } else {
                print("Cannot find the instrument file!")
            }
        } catch {
            print("Cannot load instrument!")
        }
        
        do {
            try engine.start()
        } catch {
            print("AudioKit did not start!")
        }
   
        DispatchQueue.main.async {
            self.midi.openInput()
        }
        
    }
    
    // MARK: - Public functions
    func noteOn(pitch: Pitch, point: CGPoint) {
        //synth.play(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), velocity: MIDIVelocity.max)
        instrument.play(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), velocity: MIDIVelocity.max, channel: 0)
    }
    
    func noteOff(pitch: Pitch) {
        //synth.stop(noteNumber: MIDINoteNumber(pitch.midiNoteNumber))
        instrument.stop(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), channel: 0)
    }

    // Here we'd have functions that respond to each individual MIDI CC message that comes
    // into the controller and do something fun with it. You can implement the standard
    // MIDI CC messages (search online for those values), or as a fun exercise you can
    // allow for custom mappings via the UI to map CC values to certain functions
    func handleMidiCC(_ controller: UInt8, value: UInt8, channel: UInt8) {
        switch(Int(controller)) {
        // Mod wheel
//        case 1:
//            // Just using the value adds way too much vibrato;
//            // This is a good case for having a setting.
//            synth.vibratoDepth = AUValue(value/8)
        default: break;
        }
    }
}

