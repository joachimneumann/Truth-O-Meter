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
//            .font(.headline)
            .accentColor(C.color.gray)
            .foregroundColor(C.color.gray)
            .offset(y: 15)
    }
}

struct DisplayView: View {
    @EnvironmentObject private var settings: Settings
    var colorful: Bool
    var editTitle: Bool
    @State private var editing = false
    let activeColor:Color
    let passiveColor:Color

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Spacer()
                DisplayBackground(colorful: true)
                Spacer()
                if editTitle {
                    // needle behind the text
                    NeedleView(activeColor: activeColor, passiveColor: passiveColor)
                        .clipped()
                        .opacity(0.5)
                    #if os(iOS)
                    TextField("", text: $settings.title, onEditingChanged: { edit in
                        self.editing = edit
                    })
                    .textFieldStyle(CustomTitleTextFieldStyle(focused: $editing))
                    #elseif os(macOS)
                    TextField("", text: $settings.title)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(TextAlignment.center)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    #endif
                } else {
                    // needle in front of the text
                    Text(settings.title)
                        .lineLimit(1)
                        .font(.system(size: 500).bold())
                        .minimumScaleFactor(0.01)
                        .frame(width: geo.size.width*0.6, height: geo.size.height, alignment: .center)
                        .offset(y: geo.size.height*0.15)
                        .foregroundColor(colorful ? C.color.gray : C.color.lightGray)
                    NeedleView(activeColor: activeColor, passiveColor: passiveColor)
                        .clipped()
                }
            }
        }
        .aspectRatio(DisplayBackground.aspectRatio, contentMode: .fit)
        // print("redrawing Display, colorful = \(String(colorful))")
        // I do not want to see this message very often.
        // Specifically, it should not appear every time, the needle is redrawn

    }
}
    
struct Display_Previews: PreviewProvider {
    static var previews: some View {
        let settings = Settings()
        Needle.shared.active(true, strongNoise: false)
        return Group {
            VStack {
                DisplayView(colorful: true, editTitle: false, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray)
                    .padding(200)
                    .environmentObject(settings)
            }
            VStack {
                DisplayView(colorful: true, editTitle: true, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray)
                    .padding()
                    .environmentObject(settings)
            }
            .previewDevice("iPhone 12")
        }
    }
}
