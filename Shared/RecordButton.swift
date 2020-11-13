//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI



struct RecordButton: View {
    @State private var progress = 0.0
    private var progressDuration = 2.0
    var body: some View {
        let size: CGFloat = 100
        ZStack {
            OuterRing()
                .stroke(C.Colors.lightGray, lineWidth: 3)
                .frame(width: size, height: size, alignment: .center)
            Rectangle()
                .frame(width: size*0.45, height: size*0.45, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(.red)
            Circle()
                .frame(width: size*0.9, height: size*0.9, alignment: .center)
                .foregroundColor(.red)
                .hidden()
        }
    }

    private lazy var noiseTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { _ in
        progress += 0.01
    }

    private lazy var progressTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }

    @objc func fire() {
    }
    init() {
        self.noiseTimer.fire()
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
