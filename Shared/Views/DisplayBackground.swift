//
//  DisplayBackground.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct DisplayBackground: View {
    let model: DisplayModel
    var colorful: Bool
    var passiveColor: Color
    var gray: Color
    var activeColor: Color
    var aspectRatio: Double
    var body: some View {
        ZStack {
            MainArcBlack(model: model)
                .stroke(colorful ? gray : passiveColor, style: model.boldStrokeStyle)
            MainArcRed(model: model)
                .stroke(colorful ? activeColor : passiveColor, style: model.boldStrokeStyle)
            TopArcBlack(model: model)
                .stroke(colorful ? gray : passiveColor, style: model.fineStrokeStyle)
            TopArcRed(model: model)
                .stroke(colorful ? activeColor : passiveColor, style: model.fineStrokeStyle)
                .clipped()
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(passiveColor, lineWidth: model.measures.borderLine)
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
    struct MainArcBlack: Shape {
        let model: DisplayModel
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(
                center: model.measures.displayCenter,
                radius: model.measures.radius1,
                startAngle: model.startAngle,
                endAngle: model.midAngle,
                clockwise: false)
            return path
        }
    }
    
    
    struct MainArcRed: Shape {
        let model: DisplayModel
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(
                center: model.measures.displayCenter,
                radius: model.measures.radius1,
                startAngle: model.midAngle,
                endAngle: model.endAngle,
                clockwise: false)
            return path
        }
    }
    
    struct TopArcBlack: Shape {
        let model: DisplayModel
        let proportions = [0.12, 0.2, 0.265, 0.32, 0.37, 0.42, 0.47, 0.52, 0.57, 0.62, 0.66]
        func path(in rect: CGRect) -> Path {
            var temp = Path()
            let p: Path = Path { path in
                path.addArc(
                    center: model.measures.displayCenter,
                    radius: model.measures.radius2,
                    startAngle: model.startAngle,
                    endAngle: model.midAngle,
                    clockwise: false)
                for proportion in proportions {
                    let end = Angle(radians: model.measures.angle(forProportion: proportion))
                    temp.addArc(
                        center: model.measures.displayCenter,
                        radius: model.measures.radius2,
                        startAngle: model.startAngle,
                        endAngle: end,
                        clockwise: false)
                    let a = temp.currentPoint!
                    temp.addArc(
                        center: model.measures.displayCenter,
                        radius: model.measures.radius3,
                        startAngle: model.startAngle,
                        endAngle: end,
                        clockwise: false)
                    let b = temp.currentPoint!
                    path.move(to: a)
                    path.addLine(to: b)
                }
            }
            return p
        }
    }
    
    struct TopArcRed: Shape {
        let model: DisplayModel
        func path(in rect: CGRect) -> Path {
            var temp = Path()
            let p: Path = Path { path in
                
                /// top arc
                path.addArc(
                    center: model.measures.displayCenter,
                    radius: model.measures.radius2,
                    startAngle: model.midAngle,
                    endAngle: model.endAngle,
                    clockwise: false)
                
                /// little red ticks on the right
                for proportion in [0.79, 0.87, 0.94] {
                    let end = Angle(radians: model.measures.angle(forProportion: proportion))
                    temp.addArc(
                        center: model.measures.displayCenter,
                        radius: model.measures.radius2,
                        startAngle: model.startAngle,
                        endAngle: end,
                        clockwise: false)
                    path.move(to: temp.currentPoint!)
                    temp.addArc(
                        center: model.measures.displayCenter,
                        radius: model.measures.radius3,
                        startAngle: model.startAngle,
                        endAngle: end,
                        clockwise: false)
                    path.addLine(to: temp.currentPoint!)
                }
                
                /// red divider line
                temp.addArc(
                    center: model.measures.displayCenter,
                    radius: model.measures.radius1,
                    startAngle: model.startAngle,
                    endAngle: model.midAngle,
                    clockwise: false)
                path.move(to: temp.currentPoint!)
                temp.addArc(
                    center: model.measures.displayCenter,
                    radius: model.measures.radius3,
                    startAngle: model.startAngle,
                    endAngle: model.midAngle,
                    clockwise: false)
                path.addLine(to: temp.currentPoint!)
                
                /// line at the beginning
                path.move(to: model.measures.displayCenter)
                temp.addArc(
                    center: model.measures.displayCenter,
                    radius: model.measures.radius3,
                    startAngle: model.startAngle,
                    endAngle: model.startAngle,
                    clockwise: false)
                path.addLine(to: temp.currentPoint!)
                
                /// line at the end
                path.move(to: model.measures.displayCenter)
                temp.addArc(
                    center: model.measures.displayCenter,
                    radius: model.measures.radius3,
                    startAngle: model.startAngle,
                    endAngle: model.endAngle,
                    clockwise: false)
                path.addLine(to: temp.currentPoint!)
            }
            return p
        }
    }
}


struct DisplayBackground_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            DisplayBackground(model: DisplayModel(size: geo.size), colorful: true, passiveColor: Color(white: 0.7), gray: Color.gray, activeColor: Color.red, aspectRatio: 1.9)
                .background(Color.yellow.opacity(0.2))
                .frame(width: 300, height: 200, alignment: .center)
        }
    }
}
