//
//  DisplayModel.swift
//  Truth-O-Meter (iOS)
//
//  Created by Joachim Neumann on 15/09/2021.
//

import SwiftUI

struct DisplayModel {
    var measures: DisplayMeasures
    let boldStrokeStyle: StrokeStyle
    let fineStrokeStyle: StrokeStyle
    let startAngle: Angle
    let midAngle: Angle
    let endAngle: Angle
    init(size: CGSize) {
        measures = DisplayMeasures(size)
        boldStrokeStyle = StrokeStyle(lineWidth: measures.thickLine, lineCap: .butt)
        fineStrokeStyle = StrokeStyle(lineWidth: measures.thinLine, lineCap: .butt)
        startAngle = Angle(radians: measures.startAngle)
        midAngle = Angle(radians: measures.midAngle)
        endAngle = Angle(radians: measures.endAngle)
    }
}
