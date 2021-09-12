//
//  DisplayBackground.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct DisplayBackground: View {
    static let completeAngle = Angle(degrees: 102.0)
    static let startAngle = Angle(degrees: -90.0) - completeAngle/2
    static let endAngle   = Angle(degrees: -90.0) + completeAngle/2
    static let midAngle = startAngle+(endAngle-startAngle)*0.7
    static let aspectRatio: CGFloat = 1.9
    static let thickLineFactor: CGFloat = 7

    static func proportionalAngle(proportion: Double) -> Angle {
        return startAngle+(endAngle-startAngle)*proportion
    }
    static func displayCenter(rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.midX, y: rect.origin.y + 1.2 * rect.size.height)
    }
    static func radius1(rect: CGRect) -> CGFloat { return rect.height * 0.95 }
    static func radius2(rect: CGRect) -> CGFloat { return radius1(rect: rect) * 1.07 }
    static func radius3(rect: CGRect) -> CGFloat { return radius2(rect: rect) * 1.045 }

    var colorful: Bool
    var lightColor: Color
    var darkColor: Color
    var activeColor: Color

    var body: some View {
        GeometryReader { geo in
            let lw1 = C.lw1(geo)
            let boldStrokeStyle = StrokeStyle(lineWidth: DisplayBackground.thickLineFactor*lw1, lineCap: .butt)
            let fineStrokeStyle = StrokeStyle(lineWidth: lw1, lineCap: .butt)
                ZStack {
                    MainArcBlack()
                        .stroke(colorful ? darkColor : lightColor, style: boldStrokeStyle)
                    MainArcRed()
                        .stroke(colorful ? activeColor : lightColor, style: boldStrokeStyle)
                    TopArcBlack()
                        .stroke(colorful ? darkColor : lightColor, style: fineStrokeStyle)
                    TopArcRed()
                        .stroke(colorful ? activeColor : lightColor, style: fineStrokeStyle)
                        .clipped()
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .stroke(lightColor, lineWidth: 2*lw1)
                }
        }
        .aspectRatio(DisplayBackground.aspectRatio, contentMode: .fit)
    }
}


struct MainArcBlack: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius1(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.midAngle, clockwise: false)
        return path
    }
}

struct MainArcRed: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius1(rect: rect), startAngle: DisplayBackground.midAngle, endAngle: DisplayBackground.endAngle, clockwise: false)
        return path
    }
}

struct TopArcBlack: Shape {
    func path(in rect: CGRect) -> Path {
        var temp = Path()
        let p: Path = Path { path in
            path.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius2(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.midAngle, clockwise: false)
            for proportion in [0.12, 0.2, 0.265, 0.32, 0.37, 0.42, 0.47, 0.52, 0.57, 0.62, 0.66] {
                let end = DisplayBackground.proportionalAngle(proportion: proportion)
                temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius2(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: end, clockwise: false)
                let a = temp.currentPoint!
                temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius3(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: end, clockwise: false)
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
            path.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius2(rect: rect), startAngle: DisplayBackground.midAngle, endAngle: DisplayBackground.endAngle, clockwise: false)
            
            // little red ticks on the right
            for proportion in [0.79, 0.87, 0.94] {
                let end = DisplayBackground.proportionalAngle(proportion: proportion)
                temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius2(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: end, clockwise: false)
                path.move(to: temp.currentPoint!)
                temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius3(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: end, clockwise: false)
                path.addLine(to: temp.currentPoint!)
            }
            
            // red divider line
            temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius1(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.midAngle, clockwise: false)
            path.move(to: temp.currentPoint!)
            temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius3(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.midAngle, clockwise: false)
            path.addLine(to: temp.currentPoint!)
            
            // line at the beginning
            path.move(to: DisplayBackground.displayCenter(rect: rect))
            temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius3(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.startAngle, clockwise: false)
            path.addLine(to: temp.currentPoint!)

            // line at the end
            path.move(to: DisplayBackground.displayCenter(rect: rect))
            temp.addArc(center: DisplayBackground.displayCenter(rect: rect), radius: DisplayBackground.radius3(rect: rect), startAngle: DisplayBackground.startAngle, endAngle: DisplayBackground.endAngle, clockwise: false)
            path.addLine(to: temp.currentPoint!)
        }
        return p
    }
}


struct DisplayBackground_Previews: PreviewProvider {
    static var previews: some View {
        DisplayBackground(colorful: true, lightColor: C.color.lightGray, darkColor: C.color.gray, activeColor: C.color.bullshitRed)
    }
}
