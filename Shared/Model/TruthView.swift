//
//  TruthView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 16/08/2021.
//

import SwiftUI

struct TruthView: View {
    @ObservedObject var truthViewModel: TruthViewModel
    
    var body: some View {
        // print("redrawing TruthView")
        return VStack {
            Needle(v: truthViewModel.currentValue)
                .stroke(truthViewModel.activeDisplay ? C.Colors.bullshitRed : C.Colors.lightGray,
                        style: StrokeStyle(lineWidth: C.lineWidth, lineCap: .round))
        }
        .aspectRatio(1.9, contentMode: .fit)
    }
}

struct Needle: Shape {
    var v: Double
    func path(in rect: CGRect) -> Path {
        var temp = Path()
        var path = Path()
        temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: C.proportionalAngle(proportion: v), clockwise: true)
        let a = temp.currentPoint!
        path.move(to: C.displayCenter(rect: rect))
        path.addLine(to: a)
        return path
    }
}


struct TruthView_Previews: PreviewProvider {
    static var previews: some View {
        let truthViewModel = TruthViewModel()
        VStack {
            ModelDebugView(truthViewModel: truthViewModel)
            TruthView(truthViewModel: truthViewModel)
        }
    }
}
