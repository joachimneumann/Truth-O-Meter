//
//  ShapeShifterView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct ShapeShifterView: View {
    @Binding var pale: Bool
    @Binding var circle: Bool
    @Binding var gray: Bool
    var up: () -> Void

    private let paleAnimationTime = 0.10
    private let shapeShiftAnimationTime = 0.25

    var body: some View {

        let color = Color.blue //gray ? C.color.lightGray : C.color.bullshitRed

        GeometryReader { geo in
            let w = min(geo.size.width, geo.size.height)
            VStack {
                Spacer(minLength: 0)
                Rectangle()
                    .cornerRadius(circle ? w/2 : w/14)
                    .padding(circle ? 0 : w/4)
                    .animation(.linear(duration: shapeShiftAnimationTime))
                    .foregroundColor(color)
                    .opacity(pale ? 0.3 : 1.0)
                    .animation(.linear(duration: paleAnimationTime))
                    .aspectRatio(contentMode: .fit)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if !pale {
                                    pale = true
                                }
                            }

                            .onEnded { _ in
                                pale = false
                                circle.toggle()
                                up()
//                                if circle {
//                                    print("Disk up")
//                                    up(.edge)
//                                }
                            }
                    )
                Spacer(minLength: 0)
            }
        }
    }
}

struct ShapeShifter_Previews: PreviewProvider {
    static var previews: some View {
        let buttonModel = ButtonModel(isSetting: false)
        @State var pale: Bool = false
        @State var circle: Bool = true
        @State var gray: Bool = false
        return ShapeShifterView(
            pale: $pale,
            circle: $circle,
            gray: $gray) {
            buttonModel.buttonPressedWith(.edge)
        }
    }
}
