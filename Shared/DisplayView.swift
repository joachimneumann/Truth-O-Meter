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
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(C.color.bullshitRed, lineWidth: focused ? 3 : 0))
            .background(C.color.bullshitRed.opacity(0.1))
            .multilineTextAlignment(TextAlignment.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .font(.headline)
            .accentColor(C.color.gray)
            .foregroundColor(C.color.gray)
            .offset(y: 15)
    }
}

struct DisplayView: View {
    var colorful: Bool
    @Binding var title: String
    var editTitle = false

    @State private var editing = false
        
    var body: some View {
        print("redrawing Display, colorful = \(String(colorful))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn
        return ZStack {
            if editTitle {
                DisplayBackground(colorful: true)
                    .opacity(0.5)
                NeedleView()
                    .clipped()
                    .opacity(0.5)
                TextField("", text: $title, onEditingChanged: { edit in
                    self.editing = edit
                })
                .textFieldStyle(CustomTitleTextFieldStyle(focused: $editing))
            } else {
                DisplayBackground(colorful: colorful)
                Text(title)
                    .offset(y: 15)
                    .foregroundColor(colorful ? C.color.gray : C.color.lightGray)
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
        return VStack {
            DisplayView(colorful: true, title: .constant("xx"))
                .padding()
                .environmentObject(Needle())
        }
    }
}
