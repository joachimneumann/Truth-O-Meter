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
    @State private var selectedPrecision: Precision = .middle
    @State private var stampTop: String = ""
    @State private var stampBottom: String? = nil

    private func callback(_ precision: Precision) {
        selectedPrecision = precision
        stampTop = preferences.stampTop(precision)
        stampBottom = preferences.stampBottom(precision)
        let newNeedleValue = preferences.needleValue(forPrecision: precision)
        Needle.shared.active(true, strongNoise: false)
        Needle.shared.setValue(newNeedleValue)
    }

    private var stampTopBinding: Binding<String> {
        Binding(
            get: { stampTop },
            set: { newValue in
                stampTop = newValue
                preferences.setStampTop(newValue, for: selectedPrecision)
            }
        )
    }

    private var stampBottomBinding: Binding<String> {
        Binding(
            get: { stampBottom ?? "" },
            set: { newValue in
                stampBottom = newValue
                preferences.setStampBottom(newValue, for: selectedPrecision)
            }
        )
    }

    private var iPadStampScale: CGFloat {
#if os(iOS)
        UIDevice.current.userInterfaceIdiom == .pad ? 0.65 : 1.0
#else
        1.0
#endif
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
                    .scaleEffect(iPadStampScale)
                //.background(Color.yellow.opacity(0.2))
            }
            .fixedSize(horizontal: false, vertical: true)
            if preferences.isCustom {
                EditableStampView(
                    stampTop: stampTopBinding,
                    stampBottom: stampBottomBinding
                )
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
        .onAppear() {
            Needle.shared.active(true, strongNoise: false)
            callback(selectedPrecision)
        }
    }
}


private struct CustomTextFieldStyle: TextFieldStyle {
    @EnvironmentObject private var preferences: Preferences
    @Binding var focused: Bool
    private let fontsize = 40.0
    private let cornerRadius = 6.0
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

private struct EditableStampView: View {
    @State private var editingTop = false
    @State private var editingBottom = false
    @Binding var stampTop: String
    @Binding var stampBottom: String

    var body: some View {
        VStack {
            TextField("Top", text: $stampTop, onEditingChanged: { edit in
                editingTop = edit
            })
            .textFieldStyle(CustomTextFieldStyle(focused: $editingTop))
            .padding(.top, 24)

            TextField("Bottom", text: $stampBottom, onEditingChanged: { edit in
                editingBottom = edit
            })
            .textFieldStyle(CustomTextFieldStyle(focused: $editingBottom))
            .padding(.bottom, 12)
        }
    }
}


struct PreferencesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return PreferencesDetailView(displayTitle: .constant("xx"))
    }
}
