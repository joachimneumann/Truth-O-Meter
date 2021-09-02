//
//  DetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct SettingsDetailView: View {
    @EnvironmentObject var settings: Settings
    @Binding var navigation: NavigationEnum
    @Binding var displayTitle: String
    //    @State private var title: String = "not set"
    //    @State private var result: StampTexts = StampTexts("top", "bottom")
    var body: some View {
        ZStack (alignment: .topLeading) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                Text("Back")
            }
            .padding(.leading)
            .onTapGesture {
                navigation = .settings
            }
            VStack (alignment: .center) {
                DisplayView(colorful: true, editTitle: false)//settings.isCustom)
                //                        .frame(height: geo.size.height * 0.2)
                
//                Stamp(top: settings.stampTop, bottom: settings.stampBottom)
//                SmartButtonView(displayColorful: .constant(true), showAnalysisView: .constant(false), showStampView: .constant(false))
                AllDisksView(
                    displayColorful: .constant(true),
                    showRing: .constant(false),
                    showRingWithProgress: .constant(false),
                    isSetting: true)
                //                        .frame(height: geo.size.height * 0.39)
            }
        }
        //            TheDetailView(viewModel: viewModel)
        .padding(.top, 40)
    }
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let settings = Settings()
        return SettingsDetailView(navigation: .constant(NavigationEnum.detail), displayTitle: .constant("xx"))
            .environmentObject(settings)
    }
}


//    }
//}
//
//
//#if os(iOS)
//struct CustomTextFieldStyleiOS: TextFieldStyle {
//    @Binding var focused: Bool
//    let fontsize: CGFloat = 40
//    let cornerRadius: CGFloat = 6
//    func _body(configuration: TextField<Self._Label>) -> some View {
//        configuration
//            .disableAutocorrection(true)
//            .accentColor(C.color.bullshitRed)
//            .mask(Mask())
//            .autocapitalization(.none)
//            .background(
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .strokeBorder(C.color.bullshitRed, lineWidth: focused ? 3 : 0))
//            .background(C.color.bullshitRed.opacity(0.1))
//            .multilineTextAlignment(.center)
//            .lineLimit(1)
//            .cornerRadius(cornerRadius)
//            .font(.system(size: fontsize, weight: .bold))
//            .foregroundColor(C.color.bullshitRed)
//    }
//}
//#endif
//
//
//struct EditableStampView: View {
//    @EnvironmentObject var settings: Settings
//    @State private var editingTop = false
//    @State private var editingBottom = false
//    let fontsize: CGFloat = 40
//    var body: some View {
//        VStack {
//            if settings.isCustomTheme {
//                #if os(iOS)
//                //                TextField("", text: $viewModel.customTop, onEditingChanged: { edit in
//                //                    self.editingTop = edit
//                //                })
//                //                .textFieldStyle(CustomTextFieldStyleiOS(focused: $editingTop))
//                //                .padding(.top, 24)
//                #elseif os(macOS)
//                //                TextField("", text: $viewModel.customTop, onEditingChanged: { edit in
//                //                    self.editingTop = edit
//                //                })
//                //                .textFieldStyle(PlainTextFieldStyle())
//                //                .foregroundColor(.black)
//                //                .frame(width: .infinity, height: 30, alignment: .center)
//                //                .background(C.color.bullshitRed.opacity(0.2))
//                //                .foregroundColor(C.color.bullshitRed)
//                //                .padding(.top, 24)
//                #endif
//            } else {
//                //                Text(settings.currentTheme.result(precision: viewModel.precision).top)
//                //                    .font(.system(size: fontsize, weight: .bold))
//                //                    .foregroundColor(C.color.bullshitRed)
//                //                    .mask(Mask())
//                //                    .padding(.top, 25)
//                //                    .padding(.bottom, 0)
//            }
//            //            if let b = settings.result(precision: viewModel.precision).bottom {
//            //                if settings.isCustomTheme {
//            //                    #if os(iOS)
//            //                    TextField("", text: $viewModel.customBottom, onEditingChanged: { edit in
//            //                        self.editingBottom = edit
//            //                    })
//            //                    .textFieldStyle(CustomTextFieldStyleiOS(focused: $editingBottom))
//            //                    .padding(.bottom, 12)
//            //                    #elseif os(macOS)
//            //                    TextField("", text: $viewModel.customBottom, onEditingChanged: { edit in
//            //                        self.editingBottom = edit
//            //                    })
//            //                    .textFieldStyle(PlainTextFieldStyle())
//            //                    .foregroundColor(.black)
//            //                    .frame(width: .infinity, height: 30, alignment: .center)
//            //                    .background(C.color.bullshitRed.opacity(0.2))
//            //                    .foregroundColor(C.color.bullshitRed)
//            //                    .padding(.bottom, 12)
//            //                    #endif
//            //                } else {
//            //                    Text(b)
//            //                        .font(.system(size: fontsize, weight: .bold))
//            //                        .foregroundColor(C.color.bullshitRed)
//            //                        .mask(Mask())
//            //                        .padding(.top, -10)
//            //                        .padding(.bottom, 25)
//            //                }
//            //            } else {
//            //                if settings.isCustomTheme {
//            //                    #if os(iOS)
//            //                    TextField("", text: $viewModel.customBottom, onEditingChanged: { edit in
//            //                        self.editingBottom = edit
//            //                    })
//            //                    .textFieldStyle(CustomTextFieldStyleiOS(focused: $editingBottom))
//            //                    .padding(.bottom, 12)
//            //                    #elseif os(macOS)
//            //                    #endif
//            //                } else {
//            //                    Text("no second line")
//            //                        .font(.system(size: fontsize, weight: .ultraLight))
//            //                        .foregroundColor(C.color.lightGray)
//            //                        .padding(.top, -10)
//            //                        .padding(.bottom, 25)
//            //                }
//            //            }
//        }
//    }
//}
//
//struct TheDetailView: View {
//    @ObservedObject var viewModel: ViewModel
//    var body: some View {
//        return GeometryReader { geo in
//            HStack {
//                Spacer()
//                VStack (alignment: .center) {
//                    DisplayView(viewModel: viewModel, editTitle: viewModel.settings.isCustomTheme)
//                        .frame(height: geo.size.height * 0.2)
//                    EditableStampView(viewModel: viewModel)
//                    RecordButton(viewModel: viewModel)
//                        .frame(height: geo.size.height * 0.39)
//                }
//                .padding()
//                Spacer()
//            }
//        }
//    }
//}
//
//
//#if os(macOS)
//struct VisualEffectView: NSViewRepresentable {
//    func makeNSView(context: Context) -> NSVisualEffectView {
//        let view = NSVisualEffectView()
//
//        view.blendingMode = .behindWindow    // << important !!
//        view.isEmphasized = true
//        view.layer?.backgroundColor = NSColor(red: 255, green: 0, blue: 0, alpha: 0.5).cgColor
//        view.material = .contentBackground
//        return view
//    }
//
//    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
//    }
//}
//
//extension NSTextField {
//    open override var focusRingType: NSFocusRingType {
//        get { .none }
//        set { }
//    }
//}
//
//#endif
