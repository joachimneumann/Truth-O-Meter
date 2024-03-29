//
//  PreferencesView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI



struct PreferencesView: View {
    @Binding var preferences: Preferences
    
    private struct ThemeCell: View {
        @Binding var preferences: Preferences
        let name: String
        let isSelected: Bool
        let isCustom: Bool
        var body: some View {
            HStack {
                if isSelected {
                    Text(name == "" ? "Custom" :  name)
                        .font(.headline)
                    NavigationLink(
                        destination:
                            PreferencesDetailView(preferences: $preferences,
                                                  displayTitle: $preferences.title)) {
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
                                                  }
                } else {
                    Text(name == "" ? "Custom" :  name)
                }
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.title2.weight(.bold))
                        .foregroundColor(.accentColor)
                    
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(height: 30)
        }
    }
    
    private struct ThemesList: View {
        @Binding var preferences: Preferences
        var body: some View {
            let themeNames = preferences.themeNames
            VStack {
                ForEach(themeNames) { themeName in
                    ThemeCell(
                        preferences: $preferences,
                        name: themeName.name,
                        isSelected: themeName.id == preferences.selectedThemeIndex,
                        isCustom: themeName.isCustom)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            preferences.selectedThemeIndex = themeName.id
                        }
                    Rectangle().fill(preferences.lightGray)
                        .frame(height: 0.5)
                        .padding(.leading)
                }
            }
        }
    }
    
    private struct TimePicker: View {
        @Binding var preferences: Preferences
        var body: some View {
            VStack(alignment: .leading) {
                HStack  {
                    Text("Listening time")
                        .frame(width:150, alignment: .leading)
                    Picker(selection: $preferences.listenTimingIndex, label: Text("")) {
                        Text(preferences.listenTimeStrings[0]).tag(0)
                        Text(preferences.listenTimeStrings[1]).tag(1)
                        Text(preferences.listenTimeStrings[2]).tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                }
                .padding(.leading)
                HStack {
                    Text("Analysis time")
                        .frame(width:150, alignment: .leading)
                    Picker(selection: $preferences.analysisTimingIndex, label: Text("")) {
                        Text(preferences.analysisTimeStrings[0]).tag(0)
                        Text(preferences.analysisTimeStrings[1]).tag(1)
                        Text(preferences.analysisTimeStrings[2]).tag(2)
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
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: InstructionView()) {
                    Text("Show Instructions")
                }
                Spacer()
            }
            .padding(.vertical, 40)
            TimePicker(preferences: $preferences)
            Rectangle().fill(preferences.lightGray)
                .frame(height: 0.5)
                .padding(.leading)
            ThemesList(preferences: $preferences)
            Spacer()
        }
        .frame(maxWidth: 600)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(preferences: .constant(Preferences()))
            .padding(.top, 70)
    }
}
