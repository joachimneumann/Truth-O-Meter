//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    var viewModel: ViewModel
    var editTitle = false
    @State private var titleState = ""
    var body: some View {
        let colorful = viewModel.displayBackgroundColorful
        //        print("redrawing Display, colorful = \(String(colorful))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn
        ZStack {
            if editTitle {
                DisplayBackground(colorful: colorful)
                    .opacity(0.5)
                NeedleView()
                    .clipped()
                    .opacity(0.5)
                TextField("title", text: $titleState, onEditingChanged: { (changed) in
                    if changed { viewModel.setTitle(titleState) }
                })
                .padding(6)
                .background(Color.green.opacity(0.3))
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .cornerRadius(5.0)
                .font(.headline)
                .offset(y: 15)
            } else {
                DisplayBackground(colorful: colorful)
                Text(viewModel.settings.currentTheme.title)
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
        viewModel.setCurrentTheme(viewModel.settings.themes[3])
        return VStack {
            ModelDebugView(viewModel: viewModel)
            Display(viewModel: viewModel, editTitle: true)
                .padding()
                .environmentObject(viewModel.needle)
        }
    }
}
