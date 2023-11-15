# SimpleSynth

DIY Audio with Swift and AudioKit - Example iOS app

## What is this?

This is an example project utilizing AudioKit to show off working with audio in Swift, through
the lens of creating your own software synthesizer.

## Links

* [AudioKit](https://www.audiokit.io/) - Documentation, etc.
* [Cookbook App](https://github.com/AudioKit/Cookbook) - The official example/cookbook app
* [Moby Pixel's Synth App in 100 Lines of Code](https://www.youtube.com/watch?v=OoYEYCCJyCA) - The inspiration for this 

## Extra

The sound used for the example MIDI synthesizer was created by Tim Gourley. I sampled some sounds from my
ASM HydraSynth Deluxe (the "Suitcase MKII RA" preset), loaded it into Logic Pro's sampler instrument, and
saved that as an .EXS file which AudioKit can read.

To take advantage of MIDI, you will need to either run this on a Mac with a USB MIDI controller connected,
or run it on an iOS device with a USB MIDI controller connected via a dongle to convert USB type A to the
connector of your choice (USB C or Lightning).

This software is not guaranteed to work. It's an example used for a presentation at Phase 2.
