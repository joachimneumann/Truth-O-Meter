//
//  SettingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI
import NavigationStack

struct TimePicker: View {
    @EnvironmentObject var settings: Settings
    var body: some View {
        VStack(alignment: .leading) {
            HStack  {
                Text("Listening time")
                    .frame(width:150, alignment: .leading)
                Picker(selection: $settings.listenTimingIndex, label: Text("")) {
                    Text(settings.listenTimeStrings[0]).tag(0)
                    Text(settings.listenTimeStrings[1]).tag(1)
                    Text(settings.listenTimeStrings[2]).tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 150)
            }
            .padding(.leading)
            HStack {
                Text("Analysis time")
                    .frame(width:150, alignment: .leading)
                Picker(selection: $settings.analysisTimingIndex, label: Text("")) {
                    Text(settings.analysisTimeStrings[0]).tag(0)
                    Text(settings.analysisTimeStrings[1]).tag(1)
                    Text(settings.analysisTimeStrings[2]).tag(2)
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

struct ThemeCell: View {
    @EnvironmentObject var settings: Settings
    var name: String
    var isSelected: Bool
    var isCustom: Bool
    var body: some View {
        HStack {
            if isSelected {
                Text(name == "" ? "Custom" :  name)
                    .font(.headline)
                PushView(destination: SettingsDetailView(displayTitle: $settings.title)) {
                    Group {
                        if isCustom {
                            Text("Edit")
                                .padding(.leading, 10)
                                .font(.headline)
                        } else {
                            Image(systemName: "info.circle")
                                .font(.title2.weight(.semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .foregroundColor(C.color.bullshitRed)
//                .onTapGesture {
//                    Needle.shared.active(true)
//                }
                }
            } else {
                Text(name == "" ? "Custom" :  name)
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .font(.title2.weight(.bold))
                    .foregroundColor(.blue)
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .frame(height: 30)
    }
}

struct ThemesList: View {
    @EnvironmentObject var settings: Settings
    var themeNames: [ThemeName]
    var body: some View {
        VStack {
            ForEach(themeNames) { themeName in
                ThemeCell(
                    name: themeName.name,
                    isSelected: themeName.id == settings.selectedThemeIndex,
                    isCustom: themeName.isCustom)
                .contentShape(Rectangle())
                .onTapGesture {
                    settings.selectedThemeIndex = themeName.id
                }
                Rectangle().fill(C.color.lightGray)
                    .frame(height: 0.5)
                    .padding(.leading)
            }
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    var body: some View {
        ZStack (alignment: .topLeading) {
            PopView {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 20))
                    Text("Back")
                }
                .foregroundColor(.blue)
                .padding(.leading)
            }
//            .onTapGesture {
//                navigation = .main
//                Needle.shared.active(false)
//                Needle.shared.setValue(0.5)
//            }
            VStack(alignment: .leading) {
                TimePicker()
                Rectangle().fill(C.color.lightGray)
                    .frame(height: 0.5)
                    .padding(.leading)
                ThemesList(themeNames: settings.themeNames)
                PushView(destination: InstructionView()) {
                    Text("Show Instructions")
//                    {
//                        settings.navigation = .instructions
//                    }
                }
                .padding(.top, 30)
                .padding(.leading)
                Spacer()
            }
            .padding(.top, 40)
            Spacer()
        }
        .padding(.top, 10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Settings())
            .padding(.top, 70)
    }
}
