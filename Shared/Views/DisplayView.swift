//
//  DisplayView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct CustomTitleTextFieldStyle: TextFieldStyle {
    let activeColor:Color
    let darkColor: Color
    @Binding var focused: Bool
    let cornerRadius = 5.0
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(activeColor, lineWidth: focused ? 3 : 0))
            .background(activeColor.opacity(0.1))
            .multilineTextAlignment(TextAlignment.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .accentColor(darkColor)
            .foregroundColor(darkColor)
            .offset(y: 15)
    }
}

struct DisplayView: View {
    @Binding var title: String
    var colorful: Bool
    var editTitle: Bool
    @State private var editing = false
    let activeColor:Color
    let passiveColor:Color
    let gray: Color
    
    private let aspectRatio = 1.9
    
    var body: some View {
        // print("redrawing Display, colorful = \(String(colorful))")
        /// I do not want to see this message very often.
        /// Specifically, it should not appear every time, the needle is redrawn
        GeometryReader { geo in
            let model = DisplayModel(size: geo.size)
            ZStack {
                DisplayBackground(
                    model: model,
                    colorful: true,
                    passiveColor: passiveColor,
                    gray: gray,
                    activeColor: activeColor,
                    aspectRatio: aspectRatio)
                if !editTitle {
                    Text(title)
                        .lineLimit(1)
                        .font(.system(size: 500).bold())
                        .minimumScaleFactor(0.01)
                        .frame(width: geo.size.width*0.6, height: geo.size.height, alignment: .center)
                        .offset(y: geo.size.height*0.15)
                        .foregroundColor(colorful ? gray : passiveColor)
                }
                NeedleView(
                    displayMeasures:model.measures,
                    activeColor: activeColor,
                    passiveColor: passiveColor)
                    .opacity(editTitle ? 0.5 : 1.0)
                if editTitle {
                    TextField("", text: $title, onEditingChanged: { edit in
                        self.editing = edit
                    })
                    .textFieldStyle(CustomTitleTextFieldStyle(activeColor: activeColor, darkColor: gray, focused: $editing))
                }
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Needle.shared.active(true, strongNoise: false)
        return DisplayView(title: .constant("title"), colorful: true, editTitle: false, activeColor: Color.red, passiveColor: Color(white: 0.7), gray: Color.gray)
            .padding()
            .frame(width: 390, height: 400, alignment: .center)
    }
}
