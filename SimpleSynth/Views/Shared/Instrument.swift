//
//  Instrument.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 11/14/23.
//

// Swift has some oddities where didSet operators will not be called
// on the init of base class, so we're defining a parent class to be
// used to get around that limitation.

class Instrument { }
