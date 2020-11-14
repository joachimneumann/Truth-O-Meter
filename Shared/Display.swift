//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @EnvironmentObject var guiState: GuiState
    let title: String

    var body: some View {
        VStack {
            ZStack {
                DisplayBackground()
                Text(title)
                    .offset(y: 15)
                    .foregroundColor(guiState.state == .analysing ? C.Colors.gray : C.Colors.lightGray)
                    .font(.headline)
                Needle()
                    .clipped()
            }
            if guiState.state == .analysing || guiState.state == .showingResult {
                AnalysisProgressView(guiState: guiState)
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

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Display(title: "active")
            .environmentObject(GuiState())
    }
}

struct AnalysisProgressView: View {
    var guiState: GuiState
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
                    if self.guiState.state == .analysing {
                        self.guiState.newState(state: GuiStateEnum.showingResult)
                    }
                }
            }
    }
}
