//
//  SettingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI

struct TimePicker: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack  {
                Text("Listening time")
                    .frame(width:150, alignment: .leading)
                Picker(selection: $viewModel.settings.listenTimingIndex, label: Text("")) {
                    Text("\(Int(Settings.TimingEnum.fast.time())) sec").tag(0)
                    Text("\(Int(Settings.TimingEnum.medium.time())) sec").tag(1)
                    Text("\(Int(Settings.TimingEnum.slow.time())) sec").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
            }
            .padding(.leading)
            HStack {
                Text("Analysis time")
                    .frame(width:150, alignment: .leading)
                Picker(selection: $viewModel.settings.analysisTimingIndex, label: Text("")) {
                    Text("\(Int(Settings.TimingEnum.fast.time())) sec").tag(0)
                    Text("\(Int(Settings.TimingEnum.medium.time())) sec").tag(1)
                    Text("\(Int(Settings.TimingEnum.slow.time())) sec").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom, 30)
        }
    }
}

struct ThemesList: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            ForEach(viewModel.settings.themes) { theme in
                HStack {
                    if theme == viewModel.settings.currentTheme {
                        Text(theme.title == "" ? "Custom" :  theme.title)
                        Group {
                            if viewModel.settings.isCustomTheme {
                                Text("Edit")
                                    .padding(.leading, 10)
                            } else {
                                Image(systemName: "info.circle")
                            }
                        }
                        .foregroundColor(C.Colors.bullshitRed)
                        .onTapGesture {
                            viewModel.setView(.detail)
                        }
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    } else {
                        HStack {
                            Text(theme.title == "" ? "Custom" :  theme.title)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.settings.setCurrentTheme(theme)
                        }
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.leading)
                .padding(.trailing)
                Rectangle().fill(C.Colors.lightGray)
                    .frame(width: .infinity, height: 0.5)
                    .padding(.leading)
            }
        }
        Spacer(minLength: 30)
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack(alignment: .leading) {
                TimePicker(viewModel: viewModel)
                Rectangle().fill(C.Colors.lightGray)
                    .frame(width: .infinity, height: 0.5)
                    .padding(.leading)
                ThemesList(viewModel: viewModel)
            }
            .padding(.top, 40)
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                Text("Back")
            }
            .padding(.leading)
            .onTapGesture {
                viewModel.fromSettingsViewToMainView()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: ViewModel())
            .padding(.top, 70)
    }
}
