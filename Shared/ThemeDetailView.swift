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
        GeometryReader { geo in
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Display(viewModel: viewModel)
                        .frame(height: geo.size.height * 0.2)
                    Spacer()
                    Text(viewModel.stampTexts.top)
                        .font(.system(size: 20, weight: .bold))
                    Text(viewModel.stampTexts.bottom ?? " ")
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
        let viewModel = ViewModel(Needle())
        ThemeDetailView(viewModel: viewModel, theme: viewModel.currentTheme)
    }
}
