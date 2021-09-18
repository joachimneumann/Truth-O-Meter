//
//  PreferencesDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct PreferencesDetailView: View {
    @Binding var preferences: Preferences
    @Binding var displayTitle: String
    @State private var stampTop: String = ""
    @State private var stampBottom: String? = nil

    func callback(_ precision: Precision) {
        stampTop = preferences.stampTop(precision)
        stampBottom = preferences.stampBottom(precision)
        let newNeedleValue = preferences.needleValue(forPrecision: precision)
        Needle.shared.setValue(newNeedleValue)
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            HStack {
                DisplayView(
                    title: $preferences.title,
                    colorful: true,
                    editTitle: preferences.isCustom,
                    activeColor: preferences.primaryColor,
                    passiveColor: preferences.lightGray,
                    gray: preferences.gray)
                    .padding(.trailing, 5)
                Stamp(stampTop,
                      stampBottom,
                      color: preferences.primaryColor,
                      angle: Angle(degrees: 0))
                //.background(Color.yellow.opacity(0.2))
            }
            .fixedSize(horizontal: false, vertical: true)
            if preferences.isCustom {
                EditableStampView(preferences: $preferences)
            } else {
                EmptyView()
            }
            Spacer(minLength: 0)
            FiveDisks(
                preferenceScreen: true,
                radius: 200,
                color: preferences.primaryColor,
                paleColor: Color.white,
                callback: callback)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 600)
            Spacer(minLength: 0)
        }
        .padding()
    }
}


struct CustomTextFieldStyle: TextFieldStyle {
    @Binding var preferences: Preferences
    @Binding var focused: Bool
    let fontsize = 40.0
    let cornerRadius = 6.0
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .accentColor(preferences.primaryColor)
            .mask(MaskView())
            .autocapitalization(.none)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(preferences.primaryColor, lineWidth: focused ? 3 : 0))
            .background(preferences.primaryColor.opacity(0.1))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .font(.system(size: fontsize, weight: .bold))
            .foregroundColor(preferences.primaryColor)
    }
}

struct EditableStampView: View {
    @Binding var preferences: Preferences
    @State private var editingTop = false
    @State private var editingBottom = false
    let fontsize = 40.0
    var body: some View {
        Text("xx")
//        VStack {
//            TextField("Top", text: $stampTop, onEditingChanged: { edit in
//                self.editingTop = edit
//            })
//                .textFieldStyle(CustomTextFieldStyle(preferences: $preferences, focused: $editingTop))
//                .padding(.top, 24)
//
//            TextField("Bottom", text: $preferences.nonNilStampBottom, onEditingChanged: { edit in
//                self.editingBottom = edit
//            })
//                .textFieldStyle(CustomTextFieldStyle(preferences: $preferences, focused: $editingBottom))
//                .padding(.bottom, 12)
//        }
    }
}


struct PreferencesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return PreferencesDetailView(preferences: .constant(Preferences()), displayTitle: .constant("xx"))
    }
}
