//
//  ThemeDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack (alignment: .topLeading) {
            TheDetailView(viewModel: viewModel)
                .padding(.top, 40)
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                Text("Back")
            }
            .padding(.leading)
            .onTapGesture {
                viewModel.fromDetailViewToSettingsView()
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    let fontsize: CGFloat = 40
    let cornerRadius: CGFloat = 6
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .mask(Mask())
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(C.Colors.bullshitRed, lineWidth: focused ? 3 : 0))
            .background(C.Colors.bullshitRed.opacity(0.1))
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .cornerRadius(cornerRadius)
            .font(.system(size: fontsize, weight: .bold))
            .foregroundColor(C.Colors.bullshitRed)
            .accentColor(C.Colors.bullshitRed)
    }
}


struct EditableStampView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var editingTop = false
    @State private var editingBottom = false
    let fontsize: CGFloat = 40
    var body: some View {
        VStack {
            if viewModel.settings.isCustomTheme {
                TextField("", text: $viewModel.customTop, onEditingChanged: { edit in
                    self.editingTop = edit
                })
                .textFieldStyle(CustomTextFieldStyle(focused: $editingTop))
                .padding(.top, 24)
            } else {
                Text(viewModel.settings.currentTheme.results[viewModel.precision]!.top)
                    .font(.system(size: fontsize, weight: .bold))
                    .foregroundColor(C.Colors.bullshitRed)
                    .mask(Mask())
                    .padding(.top, 25)
                    .padding(.bottom, 0)
            }
            if let b = viewModel.settings.currentTheme.results[viewModel.precision]!.bottom {
                if viewModel.settings.isCustomTheme {
                    TextField("", text: $viewModel.customBottom, onEditingChanged: { edit in
                        self.editingBottom = edit
                    })
                    .textFieldStyle(CustomTextFieldStyle(focused: $editingBottom))
                    .padding(.bottom, 12)
                } else {
                    Text(b)
                        .font(.system(size: fontsize, weight: .bold))
                        .foregroundColor(C.Colors.bullshitRed)
                        .mask(Mask())
                        .padding(.top, -10)
                        .padding(.bottom, 25)
                }
            } else {
                if viewModel.settings.isCustomTheme {
                    TextField("", text: $viewModel.customBottom, onEditingChanged: { edit in
                        self.editingBottom = edit
                    })
                    .textFieldStyle(CustomTextFieldStyle(focused: $editingBottom))
                    .padding(.bottom, 12)
                } else {
                    Text("no second line")
                        .font(.system(size: fontsize, weight: .ultraLight))
                        .foregroundColor(C.Colors.lightGray)
                        .padding(.top, -10)
                        .padding(.bottom, 25)
                }
            }
        }
    }
}
struct TheDetailView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        return GeometryReader { geo in
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Display(viewModel: viewModel, editTitle: viewModel.settings.isCustomTheme)
                        .frame(height: geo.size.height * 0.2)
                    EditableStampView(viewModel: viewModel)
                    RecordButton(viewModel: viewModel)
                        .frame(height: geo.size.height * 0.39)
                    //                        .background(Color.green)
                }
                //                .background(Color.yellow)
                .padding()
                Spacer()
            }
        }
    }
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setState(.settings)
        viewModel.setCurrentTheme(viewModel.settings.themes[3])
        return DetailView(viewModel: viewModel)
            .environmentObject(viewModel.needle)
    }
}
