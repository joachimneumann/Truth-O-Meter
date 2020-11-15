//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//


import SwiftUI
import Combine

struct RecordButton: View {
    @EnvironmentObject var guiState: GuiState
    @State var progressBarValue:CGFloat = 0
    @State var running = false
    var progressDuration = 2.0
    let ringWidth: CGFloat = 6

    var isListening: Bool {
        get {
            if guiState.state == .listen { return true }
            return false
        }
    }
    var buttonIsHidden: Bool {
        get {
            if guiState.state == .analyse { return true }
            if guiState.state == .show { return true }
            return false
        }
    }
    var body: some View {
        let size: CGFloat = 100
        ZStack {
            if buttonIsHidden {
                CircularProgressBar(ringWidth: ringWidth, value: $progressBarValue)
                .hidden()
            } else {
                Circle()
                    .stroke(C.Colors.lightGray, lineWidth:ringWidth)
                    .frame(width: size, height: size)
                Rectangle()
                    .frame(width: size*0.35, height: size*0.35)
                    .cornerRadius(10)
                    .foregroundColor(isListening ? .red : C.Colors.lightGray)
                if isListening {
                    CircularProgressBar(ringWidth: ringWidth, value: $progressBarValue)
                    .onAppear {
                        let timeInterval = 0.0020
                        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
                            self.progressBarValue += CGFloat(timeInterval / progressDuration)
                            if (self.progressBarValue >= 1.0) {
                                timer.invalidate()
                                running = false
                                progressBarValue = 0.0
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.guiState.newState(state: GuiStateEnum.analyse)
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(width: size, height: size)
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        RecordButton()
            .environmentObject(GuiState(state: .listen))
    }
}
