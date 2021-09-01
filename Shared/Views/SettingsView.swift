//
//  SettingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI

struct TimePicker: View {
    @EnvironmentObject var settings: Settings
    var body: some View {
        VStack(alignment: .leading) {
            HStack  {
                Text("Listening time")
                    .frame(width:150, alignment: .leading)
                Picker(selection: $settings.listenTimingIndex, label: Text("")) {
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
                Picker(selection: $settings.analysisTimingIndex, label: Text("")) {
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
    @EnvironmentObject var settings: Settings
    @Binding var navigation: NavigationEnum
    var body: some View {
        VStack {
            ForEach(settings.themes) { theme in
                HStack {
                    if settings.isCurrentTheme(theme) {
                        Text(theme.title == "" ? "Custom" :  theme.title)
                        Group {
                            if settings.isCustomTheme {
                                Text("Edit")
                                    .padding(.leading, 10)
                            } else {
                                Image(systemName: "info.circle")
                            }
                        }
                        .contentShape(Rectangle())
                        .foregroundColor(C.color.bullshitRed)
                        .onTapGesture {
                            navigation = .detail
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
                            settings.currentTheme = theme
                        }
                    }
                }
                .padding(.leading)
                .padding(.trailing)
                .frame(height: 25)
                Rectangle().fill(C.color.lightGray)
                    .frame(height: 0.5)
                    .padding(.leading)
            }
        }
        Spacer(minLength: 30)
    }
}

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    @Binding var navigation: NavigationEnum
    var body: some View {
        ZStack (alignment: .topLeading) {
            VStack(alignment: .leading) {
                TimePicker()
                Rectangle().fill(C.color.lightGray)
                    .frame(height: 0.5)
                    .padding(.leading)
                ThemesList(navigation: $navigation)
                Spacer()
            }
            .padding(.top, 40)
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                Text("Back")
            }
            .padding(.leading)
            .onTapGesture {
                navigation = .main
            }
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(navigation: .constant(.settings))
            .environmentObject(Settings())
            .padding(.top, 70)
    }
}
