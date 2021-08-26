//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI


struct RecordButton: View {
    private struct Measures {
        let outerRingWidth: CGFloat
        let ringsPadding:   CGFloat
        let cornerRadius:   CGFloat
        let rectanglePadding:   CGFloat
                
        init(_ diameter: CGFloat) {
            let radius = diameter / 2
            let factor:CGFloat = 0.06
            outerRingWidth   = radius * factor
            ringsPadding     = radius * factor * 1.5
            cornerRadius     = radius * 0.12
            rectanglePadding = radius * 0.6
        }
    }

    @ObservedObject var viewModel: ViewModel
    var body: some View {
        print("RecordButton: stampTexts.top = \(viewModel.settings.currentTheme.stampTexts.top)")
        return GeometryReader { (geo) in
            let measures = Measures(min(geo.size.width, geo.size.height))
            ZStack {
                switch(viewModel.state) {
                case .wait, .settings:
                    Circle()
                        .stroke(C.Colors.lightGray, lineWidth:measures.outerRingWidth)
                    Rings(viewModel: viewModel)
                        .padding(measures.ringsPadding)
                case .listen:
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
                case .analyse:
                    EmptyView()
                case .show:
                    EmptyView()
                }
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct RecordButton_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setStateWithoutTimer(.listen)
        return VStack {
            ModelDebugView(viewModel: viewModel)
            RecordButton(viewModel: viewModel)
                .padding(30)
            Spacer()
        }
    }
}
