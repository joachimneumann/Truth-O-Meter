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
                // TODO: mode all this into a ViewModel !!!
                var b: String?
                UserDefaults.standard.set(
                    viewModel.customTitle,
                    forKey: C.UserDefaultKeys.customTitle)
                UserDefaults.standard.set(
                    viewModel.settings.currentTheme.results[TapPrecision.edge]!.top,
                    forKey: C.UserDefaultKeys.customEdgeTop)
                b = viewModel.settings.currentTheme.results[TapPrecision.edge]!.bottom
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customEdgeBottom)
                b = viewModel.settings.currentTheme.results[TapPrecision.outer]!.top
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customOuterTop)
                b = viewModel.settings.currentTheme.results[TapPrecision.outer]!.bottom
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customOuterBottom)
                b = viewModel.settings.currentTheme.results[TapPrecision.middle]!.top
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customMiddleTop)
                b = viewModel.settings.currentTheme.results[TapPrecision.middle]!.bottom
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customMiddleBottom)
                b = viewModel.settings.currentTheme.results[TapPrecision.inner]!.top
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customInnerTop)
                b = viewModel.settings.currentTheme.results[TapPrecision.inner]!.bottom
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customInnerBottom)
                b = viewModel.settings.currentTheme.results[TapPrecision.bullsEye]!.top
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customBullsEyeTop)
                b = viewModel.settings.currentTheme.results[TapPrecision.bullsEye]!.bottom
                UserDefaults.standard.set(
                    b == "" ? nil : b,
                    forKey: C.UserDefaultKeys.customBullsEyeBottom)
                viewModel.setView(.settings)
            }
        }
    }
}


struct TheDetailView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        let fontsize: CGFloat = 40
        return GeometryReader { geo in
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Display(viewModel: viewModel, editTitle: viewModel.settings.isCustomTheme)
                        .frame(height: geo.size.height * 0.2)
                    ZStack {
                        if viewModel.settings.isCustomTheme {
                            TextField("line 1", text: $viewModel.customTop)
                                .padding(6)
                                .mask(Mask())
                                .background(Color.green.opacity(0.3))
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                                .cornerRadius(5.0)
                                .font(.system(size: fontsize, weight: .bold))
                                .foregroundColor(C.Colors.bullshitRed)
                                .padding(.top, 12)
                        } else {
                            Text(viewModel.settings.currentTheme.results[viewModel.precision]!.top)
                                .font(.system(size: fontsize, weight: .bold))
                                .foregroundColor(C.Colors.bullshitRed)
                                .mask(Mask())
                                .padding(.top, 30)
                                .padding(.bottom, 0)
                        }
                    }
                    if let b = viewModel.settings.currentTheme.results[viewModel.precision]!.bottom {
                        if viewModel.settings.isCustomTheme {
                            TextField("line 2", text: $viewModel.customBottom)
                                .padding(6)
                                .mask(Mask())
                                .background(Color.green.opacity(0.3))
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                                .cornerRadius(5.0)
                                .font(.system(size: fontsize, weight: .bold))
                                .foregroundColor(C.Colors.bullshitRed)
                                .padding(.bottom, 12)
                        } else {
                            Text(b)
                                .font(.system(size: fontsize, weight: .bold))
                                .foregroundColor(C.Colors.bullshitRed)
                                .mask(Mask())
                                .padding(.top, -10)
                                .padding(.bottom, 30)
                        }
                    } else {
                        Text("no second line")
                            .font(.system(size: fontsize, weight: .ultraLight))
                            .foregroundColor(C.Colors.lightGray)
                            .padding(.top, -10)
                            .padding(.bottom, 30)
                    }
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
