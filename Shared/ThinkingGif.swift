//
//  ThinkingGif.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 10/04/2021.
//


import SwiftUI
import Combine

struct ThinkingGif: View {
    @ObservedObject var viewModel: ViewModel

    #if os(macOS)
    static let images = (0...105).map {
        NSImage( contentsOfFile: Bundle.main.path( forResource: String(format: "x%03i", $0), ofType: "png" )! )
    }
    #endif

    #if os(iOS)
    static let images = (0...105).map {
        UIImage(named: String(format: "x%03i.png", $0))!
    }
    #endif

    var body: some View {
        
        #if os(macOS)
        return Image(nsImage: ThinkingGif.images[viewModel.imageIndex]!).resizable()
        #endif
        
        #if os(iOS)
        return Image(uiImage: ThinkingGif.images[viewModel.imageIndex]).resizable()
        #endif

    }
}

struct ThinkingGif_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            ThinkingGif(viewModel: ViewModel())
        }
    }
}
