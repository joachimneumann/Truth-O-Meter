//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
    @ObservedObject var buttonModel: ButtonModel
    @State var pale: Bool = false
    @State var circle: Bool = true
    @State var disksHidden = false
    private let paleAnimationTime = 0.10
    private let shapeShiftTime = 0.25
    var body: some View {
        GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(
                    pale: $pale,
                    circle: $circle,
                    gray: $buttonModel.shapeShifterIsGray) {
                    if !circle {
                        buttonModel.buttonPressedWith(.edge)
                    }
                    disksHidden = !circle
                }
                .animation(.linear(duration: shapeShiftTime))
                ZStack {
                    ForEach(buttonModel.diskParameters) { diskParameter in
                        DiskView(
                            superViewIsPale: $pale,
                            isHidden: $disksHidden,
                            drawBorder: $buttonModel.isSetting,
                            isGray: $buttonModel.isSetting) {
                            pale = false
                            circle = false
                            disksHidden = true
                            buttonModel.buttonPressedWith(diskParameter.precision)
                        }
                        .padding(diskParameter.precision.padding(radius: radius))
                    }
                }
                // hiding all but the oter ShapeShifter
                .opacity(buttonModel.disksVisible ? 1.0 : 0.0)
                // this happens without animation. The pale animation happens in the ShapeShifter
            }
        }
    }
}

struct Disks_Previews: PreviewProvider {
    static var previews: some View {
        let buttonModel = ButtonModel(isSetting: false)
        AllDisksView(buttonModel: buttonModel)
    }
}
