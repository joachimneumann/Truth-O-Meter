//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        print("redrawing Display, active = \(String(viewModel.activeDisplay))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn
        return VStack {
            ZStack {
                DisplayBackground(grayedOut: !viewModel.activeDisplay)
                Text(viewModel.displayTitle)
                    .offset(y: 15)
                    .foregroundColor(viewModel.activeDisplay ? C.Colors.gray : C.Colors.lightGray)
                    .font(.headline)
                NeedleView(viewModel: viewModel)
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
            Display(viewModel: viewModel)
                .padding()
        }
    }
}
