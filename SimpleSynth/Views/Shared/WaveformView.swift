//
//  WaveformView.swift
//  SimpleSynth
//
//  Created by Tim Gourley on 10/23/23.
//

import Accelerate
import AudioKit
import AudioKitUI
import AVFoundation
import SwiftUI

struct WaveformView: ViewRepresentable {
    private var nodeTap: RawDataTap
    private var metalFragment: FragmentBuilder
    private var plotWidth: Int = 1024
    private var plotHeight: Int = 1024
    
    public init (
        _ node: Node,
        color: Color = .gray,
        backgroundColor: Color = .clear,
        bufferSize: Int = 1024,
        width: Int = 1024,
        height: Int = 1024) {
            metalFragment = FragmentBuilder(foregroundColor: color.cg,
                                            backgroundColor: backgroundColor.cg,
                                            isCentered: true,
                                            isFilled: false)
            nodeTap = RawDataTap(node,
                                 bufferSize: UInt32(bufferSize),
                                 callbackQueue: .main)
            plotWidth = width
            plotHeight = height
    }
    
    var plot: FloatPlot {
        nodeTap.start()
        
        return FloatPlot(frame: CGRect(x: 0, y: 0, width: plotWidth, height: plotHeight), fragment: metalFragment.stringValue) {
            return nodeTap.data
        }
    }
    
    #if os(macOS)
    public func makeNSView(context: Context) -> FloatPlot { return plot }
    public func updateNSView(_ nsView: FloatPlot, context: Context) {}
    #else
    public func makeUIView(context: Context) -> FloatPlot { return plot }
    public func updateUIView(_ uiView: FloatPlot, context: Context) {}
    #endif
}
