//
//  DisplayBackground.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct Measures {
    let completeAngle = Angle(degrees: 102.0)
    let startAngle: Angle
    let endAngle: Angle
    let midAngle: Angle
    let thinLine: Double
    let thickLine: Double
    let borderLine: Double

    func angle(forProportion proportion: Double) -> Angle {
        startAngle+(endAngle-startAngle)*proportion
    }
    
    var displayCenter: CGPoint {
        let r = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return CGPoint(x: r.midX, y: r.origin.y + 1.2 * r.size.height)
    }
    var radius1: Double { size.height * 0.95 }
    var radius2: Double { radius1 * 1.07 }
    var radius3: Double { radius2 * 1.045 }

    private let size: CGSize
    private let thickLineFactor = 7.0
    
    init(_ forSize: CGSize) {
        self.size = forSize
        let centerAngle = Angle(degrees: -90.0)
        startAngle = centerAngle - completeAngle/2
        endAngle   = centerAngle + completeAngle/2
        midAngle   = startAngle+(endAngle-startAngle)*0.7
        thinLine = self.size.width / 320
        thickLine = thickLineFactor * thinLine
        borderLine = 2.0 * thinLine
    }
}

struct DisplayBackground: View {
    var measures: Measures
    var colorful: Bool
    var lightColor: Color
    var darkColor: Color
    var activeColor: Color
    var body: some View {
        let boldStrokeStyle = StrokeStyle(lineWidth: measures.thickLine, lineCap: .butt)
        let fineStrokeStyle = StrokeStyle(lineWidth: measures.thinLine, lineCap: .butt)
        ZStack {
            MainArcBlack(measures: measures)
                .stroke(colorful ? darkColor : lightColor, style: boldStrokeStyle)
            MainArcRed(measures: measures)
                .stroke(colorful ? activeColor : lightColor, style: boldStrokeStyle)
            TopArcBlack(measures: measures)
                .stroke(colorful ? darkColor : lightColor, style: fineStrokeStyle)
            TopArcRed(measures: measures)
                .stroke(colorful ? activeColor : lightColor, style: fineStrokeStyle)
                .clipped()
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(lightColor, lineWidth: measures.borderLine)
        }
        .aspectRatio(C.displayAspectRatio, contentMode: .fit)
    }
    
    init(_ forSize: CGSize, colorful: Bool, lightColor: Color, darkColor: Color, activeColor: Color) {
        measures = Measures(forSize)
        self.colorful = colorful
        self.lightColor = lightColor
        self.darkColor = darkColor
        self.activeColor = activeColor
    }
    struct MainArcBlack: Shape {
        let measures: Measures
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(center: measures.displayCenter, radius: measures.radius1, startAngle: measures.startAngle, endAngle: measures.midAngle, clockwise: false)
            return path
        }
    }
    
    
    struct MainArcRed: Shape {
        let measures: Measures
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(center: measures.displayCenter, radius: measures.radius1, startAngle: measures.midAngle, endAngle: measures.endAngle, clockwise: false)
            return path
        }
    }
    
    struct TopArcBlack: Shape {
        let proportions = [0.12, 0.2, 0.265, 0.32, 0.37, 0.42, 0.47, 0.52, 0.57, 0.62, 0.66]
        let measures: Measures
        func path(in rect: CGRect) -> Path {
            var temp = Path()
            let p: Path = Path { path in
                path.addArc(center: measures.displayCenter, radius: measures.radius2, startAngle: measures.startAngle, endAngle: measures.midAngle, clockwise: false)
                for proportion in proportions {
                    let end = measures.angle(forProportion: proportion)
                    temp.addArc(center: measures.displayCenter, radius: measures.radius2, startAngle: measures.startAngle, endAngle: end, clockwise: false)
                    let a = temp.currentPoint!
                    temp.addArc(center: measures.displayCenter, radius: measures.radius3, startAngle: measures.startAngle, endAngle: end, clockwise: false)
                    let b = temp.currentPoint!
                    path.move(to: a)
                    path.addLine(to: b)
                }
            }
            return p
        }
    }
    
    struct TopArcRed: Shape {
        let measures: Measures
        func path(in rect: CGRect) -> Path {
            var temp = Path()
            let p: Path = Path { path in
                
                /// top arc
                path.addArc(center: measures.displayCenter, radius: measures.radius2, startAngle: measures.midAngle, endAngle: measures.endAngle, clockwise: false)
                
                /// little red ticks on the right
                for proportion in [0.79, 0.87, 0.94] {
                    let end = measures.angle(forProportion: proportion)
                    temp.addArc(center: measures.displayCenter, radius: measures.radius2, startAngle: measures.startAngle, endAngle: end, clockwise: false)
                    path.move(to: temp.currentPoint!)
                    temp.addArc(center: measures.displayCenter, radius: measures.radius3, startAngle: measures.startAngle, endAngle: end, clockwise: false)
                    path.addLine(to: temp.currentPoint!)
                }
                
                /// red divider line
                temp.addArc(center: measures.displayCenter, radius: measures.radius1, startAngle: measures.startAngle, endAngle: measures.midAngle, clockwise: false)
                path.move(to: temp.currentPoint!)
                temp.addArc(center: measures.displayCenter, radius: measures.radius3, startAngle: measures.startAngle, endAngle: measures.midAngle, clockwise: false)
                path.addLine(to: temp.currentPoint!)
                
                /// line at the beginning
                path.move(to: measures.displayCenter)
                temp.addArc(center: measures.displayCenter, radius: measures.radius3, startAngle: measures.startAngle, endAngle: measures.startAngle, clockwise: false)
                path.addLine(to: temp.currentPoint!)
                
                /// line at the end
                path.move(to: measures.displayCenter)
                temp.addArc(center: measures.displayCenter, radius: measures.radius3, startAngle: measures.startAngle, endAngle: measures.endAngle, clockwise: false)
                path.addLine(to: temp.currentPoint!)
            }
            return p
        }
    }
}


struct DisplayBackground_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            DisplayBackground(geo.size, colorful: true, lightColor: C.color.lightGray, darkColor: C.color.gray, activeColor: C.color.bullshitRed)
        }
        .aspectRatio(C.displayAspectRatio, contentMode: .fit)
        .frame(width: 100, height: 100, alignment: .center)
    }
}
