//
//  ThemeDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct ThemeDetailView: View {
    @ObservedObject var viewModel: ViewModel
    var settingsViewModel = ViewModel()
    var theme: Theme

    var body: some View {
        settingsViewModel.setState(.settings)
        settingsViewModel.theme = theme
        return VStack {
            Display(viewModel: settingsViewModel)
                .padding()
            Spacer()
            Stamp(texts: Result(theme.bullsEye.top, theme.bullsEye.bottom))
            Spacer()
            RecordButton(viewModel: settingsViewModel)
//                .aspectRatio(contentMode: .fit)
                .allowsHitTesting(false)
            Spacer()
        }
        .background(Color.yellow)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ThemeDetailView(viewModel: viewModel, theme: viewModel.themes[0])
    }
}
