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
            if let sampleURL = Bundle.main.url(forResource: "Sounds/hydrasynth_mk2", withExtension: "exs") {
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
        instrument.play(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), velocity: MIDIVelocity.max, channel: 0)
    }
    
    func noteOff(pitch: Pitch) {
        instrument.stop(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), channel: 0)
    }

    // Here we'd have functions that respond to each individual MIDI CC message that comes
    // into the controller and do something fun with it. You can implement the standard
    // MIDI CC messages (search online for those values), or as a fun exercise you can
    // allow for custom mappings via the UI to map CC values to certain functions
    func handleMidiCC(_ controller: UInt8, value: UInt8, channel: UInt8) {
        switch(Int(controller)) {
        // Mod wheel
        case 1:
            instrument.midiCC(controller, value: value, channel: channel)
        // You can do different things with other CC values, such
        // as having MIDI CC 74 control volume, etc.
        // Feel free to explore this as you wish.
        case 74:
            let newVol = scale(Int(value), inMin: 0, inMax: 127, outMin: -45, outMax: 12)
            instrument.amplitude = AUValue(newVol)
        default: break;
        }
    }
   
    // A quick and dirty method to scale two range of numbers
    private func scale(_ number: Int, inMin: Int, inMax: Int, outMin: Int, outMax: Int) -> Int {
        return (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
    }
}

