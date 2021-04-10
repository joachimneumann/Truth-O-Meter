//
//  DisplayBackground.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct DisplayBackground: View {
    var grayedOut: Bool

    var body: some View {
        ZStack {
            let boldStrokeStyle = StrokeStyle(lineWidth: C.lineWidth, lineCap: .butt)
            let fineStrokeStyle = StrokeStyle(lineWidth: 1, lineCap: .butt)
            withAnimation {
                ZStack {
                    MainArcBlack()
                        .stroke(grayedOut ? C.Colors.lightGray : C.Colors.gray, style: boldStrokeStyle)
                        .clipped()
                    MainArcRed()
                        .stroke(grayedOut ? C.Colors.lightGray : C.Colors.bullshitRed, style: boldStrokeStyle)
                        .clipped()
                    TopArcBlack()
                        .stroke(grayedOut ? C.Colors.lightGray : C.Colors.gray, style: fineStrokeStyle)
                        .clipped()
                    TopArcRed()
                        .stroke(grayedOut ? C.Colors.lightGray : C.Colors.bullshitRed, style: fineStrokeStyle)
                        .clipped()
                    // border (not clipped)
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(C.Colors.lightGray, lineWidth: 4)
                }
            }
        }
    }
}


struct MainArcBlack: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: C.displayCenter(rect: rect), radius: C.radius1(rect: rect), startAngle: C.startAngle, endAngle: C.midAngle, clockwise: false)
        return path
    }
}

struct MainArcRed: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: C.displayCenter(rect: rect), radius: C.radius1(rect: rect), startAngle: C.midAngle, endAngle: C.endAngle, clockwise: false)
        return path
    }
}

struct TopArcBlack: Shape {
    func path(in rect: CGRect) -> Path {
        var temp = Path()
        let p: Path = Path { path in
            path.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: C.midAngle, clockwise: false)
            for proportion in [0.12, 0.2, 0.265, 0.32, 0.37, 0.42, 0.47, 0.52, 0.57, 0.62, 0.66] {
                let end = C.proportionalAngle(proportion: proportion)
                temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: end, clockwise: false)
                let a = temp.currentPoint!
                temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius3(rect: rect), startAngle: C.startAngle, endAngle: end, clockwise: false)
                let b = temp.currentPoint!
                path.move(to: a)
                path.addLine(to: b)
            }
        }
        return p
    }
}

struct TopArcRed: Shape {
    func path(in rect: CGRect) -> Path {
        var temp = Path()
        let p: Path = Path { path in
            
            // top arc
            path.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.midAngle, endAngle: C.endAngle, clockwise: false)
            
            // little red ticks on the right
            for proportion in [0.79, 0.87, 0.94] {
                let end = C.proportionalAngle(proportion: proportion)
                temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius2(rect: rect), startAngle: C.startAngle, endAngle: end, clockwise: false)
                path.move(to: temp.currentPoint!)
                temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius3(rect: rect), startAngle: C.startAngle, endAngle: end, clockwise: false)
                path.addLine(to: temp.currentPoint!)
            }
            
            // red divider line
            temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius1(rect: rect), startAngle: C.startAngle, endAngle: C.midAngle, clockwise: false)
            path.move(to: temp.currentPoint!)
            temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius3(rect: rect), startAngle: C.startAngle, endAngle: C.midAngle, clockwise: false)
            path.addLine(to: temp.currentPoint!)
            
            // line at the beginning
            path.move(to: C.displayCenter(rect: rect))
            temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius3(rect: rect), startAngle: C.startAngle, endAngle: C.startAngle, clockwise: false)
            path.addLine(to: temp.currentPoint!)

            // line at the end
            path.move(to: C.displayCenter(rect: rect))
            temp.addArc(center: C.displayCenter(rect: rect), radius: C.radius3(rect: rect), startAngle: C.startAngle, endAngle: C.endAngle, clockwise: false)
            path.addLine(to: temp.currentPoint!)
        }
        return p
    }
}


struct DisplayBackground_Previews: PreviewProvider {
    static var previews: some View {
        DisplayBackground(grayedOut: false)
//            .environmentObject(Model())
            .aspectRatio(1.9, contentMode: .fit)
    }
}
