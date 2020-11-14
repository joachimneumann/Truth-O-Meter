//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//


import SwiftUI

struct RecordButton: View {
    @State var isActive: Bool
    @State var progressBarValue:CGFloat = 0
    @State var running = false
    var progressDuration = 2.0
    let ringWidth: CGFloat = 6

    var body: some View {
        let tapGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({_ in
            if isActive {
                print("progress started at value \(progressBarValue)")
                running = true
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
                        }
                    }
                }
            } else {
                Circle()
                    .frame(width: size*0.8, height: size*0.8)
                    .foregroundColor(isActive ? .red : C.Colors.lightGray)
                    .gesture(tapGesture)
                    // TODO not only ignore the tabgesture, but not not have one if not active
            }
        }
    }
}



struct OuterRing: Shape {
    var progress = 0.0
    func path(in rect: CGRect) -> Path {
        var end = progress * .pi*2
        if end > .pi*2 {
            end = .pi*2
        }
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 50, startAngle: Angle(radians: 0), endAngle: Angle(radians: end), clockwise: false)
        return path
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        RecordButton(isActive: true)
    }
}
