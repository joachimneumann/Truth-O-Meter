//
//  SettingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        print("SettingsView")
        return VStack {
            HStack {
                Spacer()
                Text("Listening time")
                Picker(selection: $viewModel.listenTimingIndex, label: Text("")) {
                    Text("2 sec").tag(0)
                    Text("4 sec").tag(1)
                    Text("10 sec").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
                .padding(.leading)
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.top, 0)
            .padding(.bottom, 0)
            HStack {
                Spacer()
                Text("Analysis time")
                Picker(selection: $viewModel.analysisTimingIndex, label: Text("")) {
                    Text("2 sec").tag(0)
                    Text("4 sec").tag(1)
                    Text("10 sec").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
                .padding(.leading)
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.top, 0)
            .padding(.bottom, 30)
            VStack {
                ForEach(viewModel.settings.themes) { theme in
                    HStack {
                        if theme == viewModel.settings.currentTheme {
                            Text(theme.title)
                                .font(Font.headline.weight(.bold))
                            Spacer()
                            NavigationLink(destination: ThemeDetailView(viewModel: viewModel)) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(C.Colors.bullshitRed)
                            }
                        } else {
                            HStack {
                                Text(theme.title)
                                    .font(Font.headline)
                                Spacer()
                            }
                            .onTapGesture {
                                viewModel.setCurrentTheme(theme)
                            }
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading)
                    .padding(.trailing)
                    Rectangle().fill(C.Colors.lightGray).frame(width: .infinity, height: 0.5, alignment: .center)//.offset(y: -10)
                }
            }
            Spacer(minLength: 10)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: ViewModel())
    }
}
