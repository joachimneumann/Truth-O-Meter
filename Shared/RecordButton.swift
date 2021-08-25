//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI

struct CircleMeasures {
    let diameter:            CGFloat
    let radius:              CGFloat
    let outerRingWidth:      CGFloat
    let filledCirclePadding: CGFloat
    let cornerRadius:        CGFloat
    let rectanglePadding:    CGFloat

    let edgePadding:         CGFloat
    let outerPadding:        CGFloat
    let middlePadding:       CGFloat
    let innerPadding:        CGFloat
    let bullsEyePadding:     CGFloat

    init(_ d: CGFloat) {
        diameter            = d
        radius              = d * 0.50
        outerRingWidth      = d * 0.05
        filledCirclePadding = d * 0.07
        cornerRadius        = d * 0.05
        rectanglePadding    = radius * 0.5
        
        // Instead of 0, 0.2, 0.4, 0.6, 0.8, 1.0
        // I make the bulls eye and the out ring a bit larger
        // This makes the edge results easier to hit.
        let tapBullsEye:CGFloat = 0.2 + 0.05
        let tapInner:CGFloat    = 0.4 + 0.0125
        let tapMiddle:CGFloat   = 0.6 - 0.0125
        let tapOuter:CGFloat    = 0.8 - 0.05
        let tapEdge:CGFloat     = 1.0

        let filledCircleRadius = radius - filledCirclePadding
        edgePadding     = filledCirclePadding + filledCircleRadius * (1.0 - tapEdge)
        outerPadding    = filledCirclePadding + filledCircleRadius * (1.0 - tapOuter)
        middlePadding   = filledCirclePadding + filledCircleRadius * (1.0 - tapMiddle)
        innerPadding    = filledCirclePadding + filledCircleRadius * (1.0 - tapInner)
        bullsEyePadding = filledCirclePadding + filledCircleRadius * (1.0 - tapBullsEye)
    }
}

struct WaitRecordButton: View {
    @ObservedObject var viewModel: ViewModel
    var measures: CircleMeasures
    var body: some View {
        ZStack {
            Circle()
                .stroke(C.Colors.lightGray, lineWidth:measures.outerRingWidth)
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(measures.filledCirclePadding)
        }
    }
}

struct ListenRecordButton: View {
    @ObservedObject var viewModel: ViewModel
    var measures: CircleMeasures
    var body: some View {
        Circle()
            .stroke(C.Colors.lightGray, lineWidth:measures.outerRingWidth)
        Circle()
            .trim(from: 0, to: viewModel.listeningProgress)
            .stroke(C.Colors.bullshitRed, lineWidth:measures.outerRingWidth)
            .rotationEffect(Angle(degrees:-90))
        Rectangle()
            .foregroundColor(C.Colors.bullshitRed)
            .cornerRadius(measures.cornerRadius)
            .padding(measures.rectanglePadding)
    }
}

struct ConcentricCircles: View {
    @ObservedObject var viewModel: ViewModel
    var isSettings: Bool
    var measures: CircleMeasures
    var body: some View {
        print("ConcentricCircles: stampTexts.top = \(viewModel.settings.currentTheme.stampTexts.top)")
        return ZStack {
            Circle()
                .stroke(C.Colors.paleLightGray, lineWidth: measures.outerRingWidth)
            Circle()
                .fill(C.Colors.paleBullshitRed)
                .padding(measures.filledCirclePadding)
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(measures.edgePadding)
                .onTapGesture {
                    viewModel.tap(TapPrecision.edge)
                }
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(measures.outerPadding)
                .onTapGesture {
                    viewModel.tap(TapPrecision.outer)
                }
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(measures.middlePadding)
                .onTapGesture {
                    viewModel.tap(TapPrecision.middle)
                }
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(measures.innerPadding)
                .onTapGesture {
                    viewModel.tap(TapPrecision.inner)
                }
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(measures.bullsEyePadding)
                .onTapGesture {
                    viewModel.tap(TapPrecision.bullsEye)
                }
            if isSettings {
                Circle()
                    .stroke(C.Colors.lightGray, lineWidth: 1)
                    .padding(measures.outerPadding)
                Circle()
                    .stroke(C.Colors.lightGray, lineWidth: 1)
                    .padding(measures.middlePadding)
                Circle()
                    .stroke(C.Colors.lightGray, lineWidth: 1)
                    .padding(measures.innerPadding)
                Circle()
                    .stroke(C.Colors.lightGray, lineWidth: 1)
                    .padding(measures.bullsEyePadding)
            }
        }
    }
}


struct RecordButton: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        print("RecordButton: stampTexts.top = \(viewModel.settings.currentTheme.stampTexts.top)")
        return GeometryReader { (geo) in
            let circleMeasures = CircleMeasures(min(geo.size.width, geo.size.height))
            ZStack {
                switch(viewModel.state) {
                case .wait:
                    ConcentricCircles(viewModel: viewModel, isSettings: false, measures: circleMeasures)
                case .listen:
                    ListenRecordButton(viewModel: viewModel, measures: circleMeasures)
                case .analyse:
                    Text("analyse")
                case .show:
                    Text("show")
                case .settings:
                    ConcentricCircles(viewModel: viewModel, isSettings: true, measures: circleMeasures)
                }
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setStateWithoutTimer(.settings)
        return VStack {
            ModelDebugView(viewModel: viewModel)
            RecordButton(viewModel: viewModel)
                .padding(30)
            Spacer()
        }
    }
}
