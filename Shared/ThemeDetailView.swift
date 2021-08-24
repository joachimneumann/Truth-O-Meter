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
        settingsViewModel.currentTheme = theme
        return VStack (alignment: .center) {
            Display(viewModel: settingsViewModel)
            Spacer()
            Stamp(texts: viewModel.currentTheme.results[Model.TapPrecision.bullsEye]!, rotated: false)
            Spacer()
            RecordButton(viewModel: settingsViewModel)
                .allowsHitTesting(false)
            Spacer()
        }
        .padding(.bottom, 20)
        .padding(.top, 20)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ThemeDetailView(viewModel: viewModel, theme: viewModel.currentTheme)
    }
}
