//
//  ThemeDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct ThemeDetailView: View {
    @ObservedObject var viewModel: ViewModel
    var displayViewModel = ViewModel()
    var recordButtonViewModel = ViewModel()
    var theme: Theme
    var body: some View {
        displayViewModel.setState(.show)

        return VStack {
            Display(viewModel: displayViewModel)
                .padding(.top, 30)
                .padding()
            Spacer()
            Stamp(texts: Result("absolute", "Bullshit"))
            Spacer()
            RecordButton(viewModel: recordButtonViewModel)
                .aspectRatio(contentMode: .fit)
                .allowsHitTesting(false)
            Spacer()
        }
        .padding(.bottom, 20)
    }
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ThemeDetailView(viewModel: viewModel, theme: viewModel.themes[0])
    }
}
