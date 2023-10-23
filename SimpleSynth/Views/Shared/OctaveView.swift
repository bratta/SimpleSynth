//
//  OctaveView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/17/23.
//

import SwiftUI

struct OctaveView: View {
    @StateObject var octave = Octave()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { octave.offset = max(-2, octave.offset-1) }) {
                    Image(systemName: "arrowtriangle.backward.fill")
                        .foregroundColor(.white)
                }
                Text("Octave: \(octave.offset)")
                    .frame(maxWidth: 150)
                    .foregroundColor(.white)
                Button(action: { octave.offset = min(4, octave.offset+1) }) {
                    Image(systemName: "arrowtriangle.forward.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
        .padding(.top)
        .background(.black)
    }
}


#Preview {
    OctaveView()
}
