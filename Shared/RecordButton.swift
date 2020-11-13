//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI

struct RecordButton: View {
    @State var progressBarValue:CGFloat = 0
    @State var running = false
    private var progressDuration = 6.0
    var body: some View {
        
        let tapGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({_ in
            print("progress \(progressBarValue)")
            running = true
        })
        
        let size: CGFloat = 100
        ZStack {
            Circle()
                .stroke(C.Colors.lightGray, lineWidth:5)
                .frame(width: size, height: size)
            if running {
                Rectangle()
                    .frame(width: size*0.35, height: size*0.35)
                    .cornerRadius(10)
                    .foregroundColor(.red)
                CircularProgressBar(value: $progressBarValue)
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
                    .frame(width: size*0.85, height: size*0.85)
                    .foregroundColor(.red)
                    .gesture(tapGesture)
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

struct RecordButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordButton()
    }
}
