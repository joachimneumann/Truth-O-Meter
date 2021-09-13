//
//  SettingsDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI
import NavigationStack

struct SettingsDetailView: View {
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var navigationStack: NavigationStack
    @Binding var displayTitle: String
    
    func callback(_ precision: Precision) {
//        settings.precision = precision
//        displayColorful = true
//        showRing = false
//        showRingWithProgress = true
//
//        /// initially, set the needle a bit in the wrong direction
//        let newNeedleValue = settings.needleValue(forPrecision: precision)
//        let wrongDirection = -0.15 * (newNeedleValue-0.5)
//        Needle.shared.setValue(0.5 + wrongDirection)
//        Needle.shared.setValueInSteps(newNeedleValue, totalTime: settings.listenAndAnalysisTime)
//        Needle.shared.active(true, strongNoise: true)
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .topLeading) {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 20))
                    Text("Back")
                }
                .foregroundColor(.blue)
                .padding(.leading)
                .onTapGesture {
                    self.navigationStack.pop()
                }
                VStack(alignment: .leading) {
                    DisplayView(colorful: true, editTitle: settings.isCustom, activeColor: C.color.bullshitRed, passiveColor: C.color.lightGray, darkColor: C.color.gray)
                        .padding(.top, 40)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    if settings.isCustom {
                        EditableStampView()
                    } else {
                        VStack(alignment: .center) {
                            Spacer(minLength: 0)
                            HStack(alignment: .center) {
                                Spacer(minLength: 0)
//                                StampView(
//                                    top: settings.stampTop,
//                                    bottom: settings.stampBottom,
//                                    rotated: true,
//                                    color: C.color.bullshitRed)
//                                    .padding(20)
                                Spacer(minLength: 0)
                            }
                            Spacer(minLength: 0)
                        }
                    }
                    HStack {
                        Spacer()
                        AllDisksView(
                            isSetting: true,
                            color: C.color.bullshitRed,
                            grayColor: C.color.lightGray,
                            callback: callback)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                }
            }
            .padding(.top, 10)
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
