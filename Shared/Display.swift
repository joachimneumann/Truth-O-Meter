//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    var colorful: Bool
    var title: String

    var body: some View {
        print("redrawing Display, colorful = \(String(colorful))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn
        return VStack {
            ZStack {
                DisplayBackground(colorful: colorful)
                Text(title)
                    .offset(y: 15)
                    .foregroundColor(colorful ? C.Colors.gray : C.Colors.lightGray)
                    .font(.headline)
                NeedleView()
                    .clipped()
            }
        }
        .aspectRatio(1.9, contentMode: .fit)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        VStack {
            ModelDebugView(viewModel: viewModel)
            Display(colorful: viewModel.displayBackgroundColorful, title: viewModel.settings.currentTheme.title)
                .padding()
        }
    }
}
