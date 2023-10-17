//
//  MIDIHelper.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/10/23.
//

import Foundation
import Tonic

public class MIDIHelper {
    public enum Note : Int {
        case A0=21,  Bb0, B0, C1, Db1, D1, Eb1, E1, F1, Gb1, G1, Ab1
        case A1=33,  Bb1, B1, C2, Db2, D2, Eb2, E2, F2, Gb2, G2, Ab2
        case A2=45,  Bb2, B2, C3, Db3, D3, Eb3, E3, F3, Gb3, G3, Ab3
        case A3=57,  Bb3, B3, C4, Db4, D4, Eb4, E4, F4, Gb4, G4, Ab4
        case A4=69,  Bb4, B4, C5, Db5, D5, Eb5, E5, F5, Gb5, G5, Ab5
        case A5=81,  Bb5, B5, C6, Db6, D6, Eb6, E6, F6, Gb6, G6, Ab6
        case A6=93,  Bb6, B6, C7, Db7, D7, Eb7, E7, F7, Gb7, G7, Ab7
        case A7=105, Bb7, B7, C8, Db8, D8, Eb8, E8, F8, Gb8, G8, Ab8
        case A8=117, Bb8, B8, C9, Db9, D9, Eb9, E9, F9, Gb9, G9
    }
    
    public static func Pitch(fromNote note: Note) -> Pitch {
        return Tonic.Pitch(intValue: note.rawValue)
    }
   
    public static let MinimumRange = Pitch(fromNote: .A0)...Pitch(fromNote: .A2)
    public static let MaximumRange = Pitch(fromNote: .G7)...Pitch(fromNote: .G9)
    
    public static func PitchRange(from: Note, octaves: Int=2, octaveOffset: Int=0) -> ClosedRange<Pitch> {
        let offset = octaveOffset * 12 + from.rawValue
        let pitches = octaves * 12
        if offset <= Note.A0.rawValue {
            return MinimumRange
        }
        if offset >= Note.G7.rawValue {
            return MaximumRange
        }
        return Tonic.Pitch(intValue: offset)...Tonic.Pitch(intValue: offset + pitches)
    }
}
