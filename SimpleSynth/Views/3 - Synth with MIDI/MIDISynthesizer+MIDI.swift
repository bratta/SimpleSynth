//
//  MIDISynthesizer+MIDI.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/23/23.
//

import Foundation
import AudioKit
import CoreMIDI


extension MIDISynthesizer : MIDIListener {
    // MARK: - Core MIDI support methods
    
    // This is fired when a MIDI note on event is triggered.
    // This happens when you press a key on your MIDI controller.
    func receivedMIDINoteOn(noteNumber: AudioKit.MIDINoteNumber, velocity: AudioKit.MIDIVelocity, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
        if (velocity > 0) {
            self.instrument.play(noteNumber: noteNumber, velocity: velocity, channel: channel)
        } else {
            self.instrument.stop(noteNumber: noteNumber, channel: channel)
        }
    }

    // This is fired when a MIDI note off event is triggered.
    // This happens when you let go of a key on the MIDI controller.
    func receivedMIDINoteOff(noteNumber: AudioKit.MIDINoteNumber, velocity: AudioKit.MIDIVelocity, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
        self.instrument.stop(noteNumber: noteNumber, channel: channel)
    }

    // This handles any MIDI CC messages that come in. Your controller
    // may have a variety of wheels, knobs, sliders, or buttons that can be
    // mapped to do different things. This passes the message onto the synthesizer
    // for processing.
    func receivedMIDIController(_ controller: AudioKit.MIDIByte, value: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
        self.handleMidiCC(controller, value: value, channel: channel)
    }

    // Pitch bend is its own thing in MIDI, so this event handles that. It is
    // super fine-grained in comparison to other settings using smaller values (typically 0-127).
    // This allows for a super-buttery smooth pitch bend when playing.
    func receivedMIDIPitchWheel(_ pitchWheelValue: AudioKit.MIDIWord, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
        // Values range from 0 - 16383; 8192 represents no bend at all
        self.instrument.setPitchbend(amount: pitchWheelValue, channel: channel)
    }
  
    // MARK: - Extra MIDI support methods
    // TODO: Implement these methods for better MIDI support
    func receivedMIDIAftertouch(noteNumber: AudioKit.MIDINoteNumber, pressure: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDIAftertouch(_ pressure: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    
    func receivedMIDIProgramChange(_ program: AudioKit.MIDIByte, channel: AudioKit.MIDIChannel, portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDISystemCommand(_ data: [AudioKit.MIDIByte], portID: MIDIUniqueID?, timeStamp: MIDITimeStamp?) {
    }
    
    func receivedMIDISetupChange() {
    }
    
    func receivedMIDIPropertyChange(propertyChangeInfo: MIDIObjectPropertyChangeNotification) {
    }
    
    func receivedMIDINotification(notification: MIDINotification) {
    }
}
