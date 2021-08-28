//
//  DisplayView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct CustomTitleTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    let fontsize: CGFloat = 40
    let cornerRadius: CGFloat = 5
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(C.Colors.bullshitRed, lineWidth: focused ? 3 : 0))
            .background(C.Colors.bullshitRed.opacity(0.1))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .font(.headline)
            .accentColor(C.Colors.gray)
            .foregroundColor(C.Colors.gray)
            .offset(y: 15)
    }
}

struct DisplayView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var editing = false
    var editTitle = false
        
    var body: some View {
        let colorful = viewModel.displayBackgroundColorful
        print("redrawing Display, colorful = \(String(colorful))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn
        return ZStack {
            if editTitle {
                DisplayBackground(colorful: colorful)
                    .opacity(0.5)
                NeedleView()
                    .clipped()
                    .opacity(0.5)
                TextField("", text: $viewModel.customTitle, onEditingChanged: { edit in
                    self.editing = edit
                })
                .textFieldStyle(CustomTitleTextFieldStyle(focused: $editing))
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
        viewModel.settings.setCurrentTheme(viewModel.settings.themes[3])
        return VStack {
            ModelDebugView(viewModel: viewModel)
            DisplayView(viewModel: viewModel, editTitle: true)
                .padding()
                .environmentObject(viewModel.needle)
        }
    }
}
