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
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .topLeading) {
                    HStack(spacing: 0) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 20))
                        Text("Back")
                    }
                    .padding(.leading)
                    .foregroundColor(.blue)
                .onTapGesture {
                    self.navigationStack.pop()
                }
                VStack(alignment: .leading) {
                    DisplayView(colorful: true, editTitle: settings.isCustom)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                    if settings.isCustom {
                        EditableStampView()
                    } else {
                        Stamp(top: settings.stampTop, bottom: settings.stampBottom, rotated: false)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                    }
                    HStack {
                        Spacer()
                        AllDisksView(
                            displayColorful: .constant(true),
                            showRing: .constant(false),
                            showRingWithProgress: .constant(false),
                            isSetting: true,
                            geoSize: geo.size)
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                }
                .padding(.top, 40)
                Spacer()
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


#if os(iOS)
struct CustomTextFieldStyleiOS: TextFieldStyle {
    @Binding var focused: Bool
    let fontsize: CGFloat = 40
    let cornerRadius: CGFloat = 6
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .accentColor(C.color.bullshitRed)
            .mask(Mask())
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
#endif


struct EditableStampView: View {
    @EnvironmentObject private var settings: Settings
    @State private var editingTop = false
    @State private var editingBottom = false
    let fontsize: CGFloat = 40
    var body: some View {
        VStack {
            #if os(iOS)
            TextField("Top", text: $settings.stampTop, onEditingChanged: { edit in
                self.editingTop = edit
            })
            .textFieldStyle(CustomTextFieldStyleiOS(focused: $editingTop))
            .padding(.top, 24)
            
            TextField("Bottom", text: $settings.nonNilStampBottom, onEditingChanged: { edit in
                self.editingBottom = edit
            })
            .textFieldStyle(CustomTextFieldStyleiOS(focused: $editingBottom))
            .padding(.bottom, 12)
            #elseif os(macOS)
            Group {
                TextField("top", text: $settings.stampTop)
                .padding(.top, 24)
                
                TextField("Bottom", text: $settings.nonNilStampBottom)
                .padding(.bottom, 12)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            #endif
        }
    }
}
