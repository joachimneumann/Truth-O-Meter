//
//  ShapeShifter.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct ShapeShifter: View {
    var down: (_: Precision) -> Void
    var up: (_: Precision) -> Void
    var pale: Bool
    var circle: Bool
    var gray: Bool
    
    
    private let paleAnimationTime = 0.10

    var body: some View {

        let color = gray ? C.color.lightGray : C.color.bullshitRed

        GeometryReader { geo in
            let w = min(geo.size.width, geo.size.height)
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .cornerRadius(circle ? w/2 : w/14)
                    .padding(circle ? 0 : w/4)
                    .foregroundColor(color)
                    .opacity(pale ? 0.3 : 1.0)
                    .animation(.linear(duration: paleAnimationTime))
                    .aspectRatio(contentMode: .fit)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if circle {
                                    print("ShapeShifter down")
                                    down(.edge)
                                }
                            }

                            .onEnded { _ in
                                if circle {
                                    print("Disk up")
                                    up(.edge)
                                }
                            }
                    )
                Spacer(minLength: 0)
            }
        }
    }
}

struct ShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        let diskViewModel = DiskViewModel(
            callback: viewModel.tap,
            isSetting: viewModel.isSettingsState)
        ShapeShifter(
            down: diskViewModel.down,
            up: diskViewModel.up,
            pale: diskViewModel.shapeShifterIsPale,
            circle: diskViewModel.shapeShifterIsCircle,
            gray: diskViewModel.shapeShifterIsGray)
    }
}
