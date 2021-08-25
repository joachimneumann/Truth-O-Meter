//
//  ThemeDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct ThemeDetailView: View {
    @ObservedObject var viewModel: ViewModel
    var theme: Theme
    var body: some View {
        viewModel.settings.currentTheme = theme
        print("ThemeDetailView: stampTexts.top = \(viewModel.settings.currentTheme.stampTexts.top)")
        return GeometryReader { geo in
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Display(colorful:true, title: viewModel.settings.currentTheme.title)
                        .frame(height: geo.size.height * 0.2)
                    Spacer()
                    Text(viewModel.settings.currentTheme.stampTexts.top)
                        .font(.system(size: 20, weight: .bold))
                    Text(viewModel.settings.currentTheme.stampTexts.bottom ?? " ")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    RecordButton(viewModel: viewModel)
                        .frame(height: geo.size.height * 0.39)
                        .background(Color.green)
                }
                .background(Color.yellow)
                .padding()
                .navigationBarTitle("", displayMode: .inline)
                Spacer()
            }
        }
    }
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ThemeDetailView(viewModel: viewModel, theme: viewModel.settings.currentTheme)
    }
}
