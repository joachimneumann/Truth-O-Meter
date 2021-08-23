//
//  SettingsView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/12/20.
//

import SwiftUI

struct ThemeCell: View {
    @ObservedObject var viewModel: ViewModel
    var theme: Theme
    var body: some View {
        HStack {
            NavigationLink(destination: ThemeDetailView(viewModel: viewModel, theme: theme)) {
                HStack {
                    Text(theme.displayText)
                    Spacer()
                }
            }
//            .simultaneousGesture(TapGesture().onEnded{
//                viewModel.setState(.settings)
//            })
        }
    }
}

struct SettingsView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var favoriteColor = 0
    var body: some View {
        let themes: [Theme] = viewModel.themes
        return VStack {
            HStack {
                Text("Response time")
                Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                                Text("2 sec").tag(0)
                                Text("4 sec").tag(1)
                                Text("10 sec").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            .padding(.top, 20)
            .padding(.bottom, 20)
            List {
                Section(header: Text("Theme")) {
                    ForEach(themes) { theme in
                        ThemeCell(viewModel: viewModel, theme: theme)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: ViewModel())
    }
}
