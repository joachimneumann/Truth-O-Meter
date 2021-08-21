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

    static let images = (0...105).map {
        CPImage(named: String(format: "x%03i", $0))
    }

    var body: some View {
        return Image(cpImage: ThinkingGif.images[viewModel.imageIndex]!).resizable()
    }
}

struct ThinkingGif_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            ThinkingGif(viewModel: ViewModel())
        }
    }
}
