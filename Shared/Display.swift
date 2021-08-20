//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @ObservedObject var truthViewModel: ViewModel

    var body: some View {
        // print("redrawing Display, active = \(String(truthViewModel.activeDisplay))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn
        return VStack {
            ZStack {
                DisplayBackground(grayedOut: !truthViewModel.activeDisplay)
                Text(truthViewModel.displayTitle)
                    .offset(y: 15)
                    .foregroundColor(truthViewModel.activeDisplay ? C.Colors.gray : C.Colors.lightGray)
                    .font(.headline)
                NeedleView(truthViewModel: truthViewModel)
                    .clipped()
            }
        }
        .aspectRatio(1.9, contentMode: .fit)
        .padding(30)
        .padding(.top, 10)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        let truthViewModel = ViewModel()
        VStack {
            ModelDebugView(truthViewModel: truthViewModel)
            Display(truthViewModel: truthViewModel)
        }
    }
}
