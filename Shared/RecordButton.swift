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

    var body: some View {
        let tapGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({_ in
            if guiState.state == .waiting || guiState.state == .showingResult {
                print("progress started at value \(progressBarValue)")
                running = true
                guiState.newState(state: .listening)
            }
        })

        let size: CGFloat = 100
        ZStack {
            Circle()
                .stroke(C.Colors.lightGray, lineWidth:ringWidth)
                .frame(width: size, height: size)
            if running {
                Rectangle()
                    .frame(width: size*0.35, height: size*0.35)
                    .cornerRadius(10)
                    .foregroundColor(.red)
                CircularProgressBar(ringWidth: ringWidth, value: $progressBarValue)
                .onAppear {
                    let timeInterval = 0.0020
                    Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
                        self.progressBarValue += CGFloat(timeInterval / progressDuration)
                        if (self.progressBarValue >= 1.0) {
                            timer.invalidate()
                            running = false
                            progressBarValue = 0.0
                            self.guiState.newState(state: GuiStateEnum.doneListening)
                        }
                    }
                }
            } else {
                Circle()
                    .frame(width: size*0.8, height: size*0.8)
                    .foregroundColor(guiState.state == .waiting || guiState.state == .showingResult ? .red : C.Colors.lightGray)
                    .gesture(tapGesture)
                    // TODO not only ignore the tabgesture, but not not have one if not active
            }
        }
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        RecordButton()
            .environmentObject(GuiState())
    }
}
