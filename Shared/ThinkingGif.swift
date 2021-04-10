//
//  ThinkingGif.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 10/04/2021.
//


import SwiftUI
import Combine

struct ThinkingGif: View {
    @State var index = 0
    
    static let images = (0...105).map {
        UIImage(named: String(format: "x%03i.png", $0))!
    }

    var timer = LoadingTimer()

    var body: some View {
        return Image(uiImage: ThinkingGif.images[index])
            .onReceive(
                timer.publisher,
                perform: { _ in
                    self.index = self.index + 1
                    if self.index > 105 { self.index = 0 }
                }
            )
            .onAppear { self.timer.start() }
            .onDisappear { self.timer.cancel() }
    }
}

struct ThinkingGif_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            ThinkingGif()
        }
    }
}
