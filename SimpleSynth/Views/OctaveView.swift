//
//  OctaveView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/17/23.
//

import SwiftUI

struct OctaveView: View {
    @StateObject var synthesizer: Synthesizer
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { synthesizer.octaveOffset = max(-2, synthesizer.octaveOffset-1) }) {
                    Image(systemName: "arrowtriangle.backward.fill")
                        .foregroundColor(.white)
                }
                Text("Octave: \(synthesizer.octaveOffset)")
                    .frame(maxWidth: 150)
                    .foregroundColor(.white)
                Button(action: { synthesizer.octaveOffset = min(4, synthesizer.octaveOffset+1) }) {
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
    OctaveView(synthesizer: Synthesizer())
}
