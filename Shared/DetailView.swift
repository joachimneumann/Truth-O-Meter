//
//  ThemeDetailView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 23/08/2021.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        print("DetailView")
        return GeometryReader { geo in
            HStack {
                Spacer()
                VStack (alignment: .center) {
                    Display(colorful:true, title: viewModel.settings.currentTheme.title)
                        .frame(height: geo.size.height * 0.2)
                    Text(viewModel.stampTexts.top)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(C.Colors.bullshitRed)
                        .mask(Mask())
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                    if let b = viewModel.stampTexts.bottom {
                        Text(b)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(C.Colors.bullshitRed)
                            .mask(Mask())
                            .padding(.bottom, 30)
                    } else {
                        Text("no second line")
                            .font(.system(size: 50, weight: .ultraLight))
                            .foregroundColor(C.Colors.lightGray)
//                            .mask(Mask())
                            .padding(.bottom, 30)
                    }
                    RecordButton(viewModel: viewModel)
                        .frame(height: geo.size.height * 0.39)
//                        .background(Color.green)
                }
//                .background(Color.yellow)
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
        viewModel.setState(.settings)
        return DetailView(viewModel: viewModel)
            .environmentObject(viewModel.needle)
    }
}
