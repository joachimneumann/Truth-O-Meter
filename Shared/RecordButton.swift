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
    let tapBullsEye:         CGFloat
    let tapInner:            CGFloat
    let tapMiddle:           CGFloat
    let tapOuter:            CGFloat
    let tapEdge:             CGFloat

    let filledCircleRadius:  CGFloat
    
    let edgeLineWidth:       CGFloat
    let edgePadding:         CGFloat
    let outerLineWidth:      CGFloat
    let outerPadding:        CGFloat
    let middleLineWidth:     CGFloat
    let middlePadding:       CGFloat
    let innerLineWidth:      CGFloat
    let innerPadding:        CGFloat
    let bullsEyeLineWidth:   CGFloat
    let bullsEyePadding:     CGFloat

    init(_ d: CGFloat) {
        diameter            = d
        radius              = d * 0.50
        outerRingWidth      = d * 0.05
        filledCirclePadding = d * 0.07
        cornerRadius        = d * 0.05
        rectanglePadding    = radius * 0.5
        tapBullsEye         = 0.2
        tapInner            = 0.4
        tapMiddle           = 0.6
        tapOuter            = 0.8
        tapEdge             = 1.0

        filledCircleRadius = radius - filledCirclePadding
        edgeLineWidth     = filledCircleRadius * (1.0 - tapOuter)
        edgePadding       = filledCircleRadius  * (1.0 - (1.0+tapOuter)/2) + filledCirclePadding
        outerLineWidth    = filledCircleRadius * (tapOuter - tapMiddle)
        outerPadding      = filledCircleRadius  * (1.0 - (tapOuter+tapMiddle)/2) + filledCirclePadding
        middleLineWidth   = filledCircleRadius * (tapMiddle - tapInner)
        middlePadding     = filledCircleRadius  * (1.0 - (tapMiddle+tapInner)/2) + filledCirclePadding
        innerLineWidth    = filledCircleRadius * (tapInner - tapBullsEye)
        innerPadding      = filledCircleRadius  * (1.0 - (tapInner+tapBullsEye)/2) + filledCirclePadding
        bullsEyeLineWidth = filledCircleRadius * (tapBullsEye)
        bullsEyePadding   = filledCircleRadius - bullsEyeLineWidth/2 + filledCirclePadding
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
        .onClickGesture { point in
            let distanceFromCenter = sqrt(
                pow((point.x - measures.filledCircleRadius), 2) +
                pow((point.y - measures.filledCircleRadius), 2))
            let normalisedDistanceFromCenter = distanceFromCenter / measures.filledCircleRadius
            var tapPrecision = Model.TapPrecision.bullsEye
            if normalisedDistanceFromCenter > measures.tapBullsEye { tapPrecision = Model.TapPrecision.inner   }
            if normalisedDistanceFromCenter > measures.tapInner    { tapPrecision = Model.TapPrecision.middle  }
            if normalisedDistanceFromCenter > measures.tapMiddle   { tapPrecision = Model.TapPrecision.outer   }
            if normalisedDistanceFromCenter > measures.tapOuter    { tapPrecision = Model.TapPrecision.outside }
            self.viewModel.tabWithPrecision(tapPrecision)
            withAnimation {
                self.viewModel.setState(.listen)
            }
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

struct SettingsRecordButton: View {
    var measures: CircleMeasures
    var body: some View {
        Circle()
            .stroke(C.Colors.paleLightGray, lineWidth: measures.outerRingWidth)
        Circle()
            .fill(C.Colors.paleBullshitRed)
            .padding(measures.filledCirclePadding)
        Circle()
            .stroke(C.Colors.bullshitRed, lineWidth: measures.edgeLineWidth)
            .padding(measures.edgePadding)
        Circle()
            .stroke(C.Colors.bullshitRed, lineWidth: measures.outerLineWidth)
            .padding(measures.outerPadding)
        Circle()
            .stroke(C.Colors.bullshitRed, lineWidth: measures.middleLineWidth)
            .padding(measures.middlePadding)
        Circle()
            .stroke(C.Colors.bullshitRed, lineWidth: measures.innerLineWidth)
            .padding(measures.innerPadding)
        Circle()
            .stroke(C.Colors.bullshitRed, lineWidth: measures.bullsEyeLineWidth)
            .padding(measures.bullsEyePadding)
    }
}


struct RecordButton: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geo) in
            let circleMeasures = CircleMeasures(min(geo.size.width, geo.size.height))
            ZStack {
                switch(viewModel.state) {
                case .wait:
                    WaitRecordButton(viewModel: viewModel, measures: circleMeasures)
                case .listen:
                    ListenRecordButton(viewModel: viewModel, measures: circleMeasures)
                case .analyse:
                    Text("analyse")
                case .show:
                    Text("show")
                case .settings:
                    SettingsRecordButton(measures: circleMeasures)
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

struct ClickGesture: Gesture {
    let count: Int
    let coordinateSpace: CoordinateSpace
    
    typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
    
    init(count: Int = 1, coordinateSpace: CoordinateSpace = .local) {
        precondition(count > 0, "Count must be greater than or equal to 1.")
        self.count = count
        self.coordinateSpace = coordinateSpace
    }
    
    var body: SimultaneousGesture<TapGesture, DragGesture> {
        SimultaneousGesture(
            TapGesture(count: count),
            DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
        )
    }
    
    func onEnded(perform action: @escaping (CGPoint) -> Void) -> _EndedGesture<ClickGesture> {
        self.onEnded { (value: Value) -> Void in
            guard value.first != nil else { return }
            guard let location = value.second?.startLocation else { return }
            guard let endLocation = value.second?.location else { return }
            guard ((location.x-1)...(location.x+1)).contains(endLocation.x),
                  ((location.y-1)...(location.y+1)).contains(endLocation.y) else {
                return
            }
            action(location)
        }
    }
}

extension View {
    func onClickGesture(
        count: Int,
        coordinateSpace: CoordinateSpace = .local,
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        gesture(ClickGesture(count: count, coordinateSpace: coordinateSpace)
            .onEnded(perform: action)
        )
    }
    
    func onClickGesture(
        count: Int,
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        onClickGesture(count: count, coordinateSpace: .local, perform: action)
    }
    
    func onClickGesture(
        perform action: @escaping (CGPoint) -> Void
    ) -> some View {
        onClickGesture(count: 1, coordinateSpace: .local, perform: action)
    }
}
