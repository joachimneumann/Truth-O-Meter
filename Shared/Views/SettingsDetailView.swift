//
//  SettingsDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct SettingsDetailView: View {
    @EnvironmentObject private var settings: Settings
    @Binding var displayTitle: String
    
    func callback(_ precision: Precision) {
        settings.precision = precision
        let newNeedleValue = settings.needleValue(forPrecision: precision)
        Needle.shared.setValue(newNeedleValue)
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            HStack {
                DisplayView(colorful: true, editTitle: settings.isCustom, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray, darkColor: C.color.gray)
                //.background(Color.green.opacity(0.2))
                    .padding(.trailing, 5)
                Stamp(settings.stampTop,
                      settings.stampBottom,
                      angle: Angle(degrees: 0))
                //.background(Color.yellow.opacity(0.2))
            }
            .fixedSize(horizontal: false, vertical: true)
            if settings.isCustom {
                EditableStampView()
            } else {
                EmptyView()
            }
            Spacer(minLength: 0)
            AllDisksView(
                isSetting: true,
                color: C.color.bullshitRed,
                grayColor: C.color.lightGray,
                callback: callback)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 600)
            Spacer(minLength: 0)
        }
        .padding()
    }
}


struct CustomTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    let fontsize = 40.0
    let cornerRadius = 6.0
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .accentColor(C.color.bullshitRed)
            .mask(MaskView())
            .autocapitalization(.none)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(C.color.bullshitRed, lineWidth: focused ? 3 : 0))
            .background(C.color.bullshitRed.opacity(0.1))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .font(.system(size: fontsize, weight: .bold))
            .foregroundColor(C.color.bullshitRed)
    }
}

struct EditableStampView: View {
    @EnvironmentObject private var settings: Settings
    @State private var editingTop = false
    @State private var editingBottom = false
    let fontsize = 40.0
    var body: some View {
        VStack {
            TextField("Top", text: $settings.stampTop, onEditingChanged: { edit in
                self.editingTop = edit
            })
                .textFieldStyle(CustomTextFieldStyle(focused: $editingTop))
                .padding(.top, 24)
            
            TextField("Bottom", text: $settings.nonNilStampBottom, onEditingChanged: { edit in
                self.editingBottom = edit
            })
                .textFieldStyle(CustomTextFieldStyle(focused: $editingBottom))
                .padding(.bottom, 12)
        }
    }
}


struct SettingsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let settings = Settings()
        return SettingsDetailView(displayTitle: .constant("xx"))
            .environmentObject(settings)
    }
}
