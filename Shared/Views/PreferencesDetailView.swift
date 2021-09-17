//
//  PreferencesDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct PreferencesDetailView: View {
    @EnvironmentObject private var preferences: Preferences
    @Binding var displayTitle: String
    
    func callback(_ precision: Precision) {
        preferences.precision = precision
        let newNeedleValue = preferences.needleValue(forPrecision: precision)
        Needle.shared.setValue(newNeedleValue)
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            HStack {
                DisplayView(
                    colorful: true,
                    editTitle: preferences.isCustom,
                    activeColor: preferences.colors.bullshitRed,
                    passiveColor: preferences.colors.lightGray,
                    darkColor: preferences.colors.gray)
                    .padding(.trailing, 5)
                Stamp(preferences.stampTop,
                      preferences.stampBottom,
                      angle: Angle(degrees: 0))
                //.background(Color.yellow.opacity(0.2))
            }
            .fixedSize(horizontal: false, vertical: true)
            if preferences.isCustom {
                EditableStampView()
            } else {
                EmptyView()
            }
            Spacer(minLength: 0)
            FiveDisks(
                isTapped: .constant(false),
                preferencesPrecision: $preferences.precision,
                radius: 200,
                color: preferences.colors.bullshitRed,
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
    @EnvironmentObject private var preferences: Preferences
    @Binding var focused: Bool
    let fontsize = 40.0
    let cornerRadius = 6.0
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .accentColor(preferences.colors.bullshitRed)
            .mask(MaskView())
            .autocapitalization(.none)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(preferences.colors.bullshitRed, lineWidth: focused ? 3 : 0))
            .background(preferences.colors.bullshitRed.opacity(0.1))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .font(.system(size: fontsize, weight: .bold))
            .foregroundColor(preferences.colors.bullshitRed)
    }
}

struct EditableStampView: View {
    @EnvironmentObject private var preferences: Preferences
    @State private var editingTop = false
    @State private var editingBottom = false
    let fontsize = 40.0
    var body: some View {
        VStack {
            TextField("Top", text: $preferences.stampTop, onEditingChanged: { edit in
                self.editingTop = edit
            })
                .textFieldStyle(CustomTextFieldStyle(focused: $editingTop))
                .padding(.top, 24)
            
            TextField("Bottom", text: $preferences.nonNilStampBottom, onEditingChanged: { edit in
                self.editingBottom = edit
            })
                .textFieldStyle(CustomTextFieldStyle(focused: $editingBottom))
                .padding(.bottom, 12)
        }
    }
}


struct PreferencesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let preferences = Preferences()
        return PreferencesDetailView(displayTitle: .constant("xx"))
            .environmentObject(preferences)
    }
}
