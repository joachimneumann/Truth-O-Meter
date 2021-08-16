//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        print("redrawing Display, active = \(viewModel.displayActive())")
        // I do not want to see this massage very often.
        // Specifically, it should not appear every time, the needle is redrawn
        return VStack {
            ZStack {
                DisplayBackground(grayedOut: !viewModel.displayActive())
                Text(viewModel.displayTitle())
                    .offset(y: 15)
                    .foregroundColor(viewModel.displayActive() ? C.Colors.gray : C.Colors.lightGray)
                    .font(.headline)
                NeedleView()
                    .clipped()
            }
            if viewModel.displayActive() {
                AnalysisProgressView()
            } else {
                AnalysisProgressView()
                    .hidden()
            }

        }
        .aspectRatio(1.9, contentMode: .fit)
        .padding(30)
        .padding(.top, 10)
    }
}

struct CustomLinearProgressViewStyle1: ProgressViewStyle {

    var progressColour: Color = .blue
    var successColour: Color = .green
    var progress: CGFloat
    var total: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .foregroundColor(progress >= total ? successColour : progressColour)
            .accentColor(progress >= total ? successColour : progressColour)
            .animation(Animation.linear(duration: 1))
    }

}


struct AnalysisProgressView: View {
    @State private var progress: CGFloat = 0
    var total: CGFloat = 100
    let timer = Timer.publish(every: 0.25, on: .main, in: .default).autoconnect()
    var body: some View {
        ProgressView(value: progress, total: total)
            .progressViewStyle( CustomLinearProgressViewStyle1(progress: progress, total: total))
            .padding(0)
            .onReceive(timer) { _ in
                if progress < total {
                    self.progress += 10
                } else {
                    self.progress = 100
                    timer.upstream.connect().cancel()
//                    if self.guiState.state == .analyse {
//                        withAnimation(.easeInOut(duration: 0.5)) {
//                            self.guiState.newState(state: GuiStateEnum.show)
//                        }
//                    }
                }
            }
    }
}


struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Display()
            .environmentObject(ViewModel())
            .environmentObject(NeedleViewModel())
    }
}
