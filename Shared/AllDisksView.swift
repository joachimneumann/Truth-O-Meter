//
//  AllDisksView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct AllDisksView: View {
    @ObservedObject var buttonModel: ButtonModel
    private let paleAnimationTime = 0.10
    private let shapeShiftTime = 0.25
    var body: some View {
        GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifterView(down: buttonModel.down,
                             up: buttonModel.up,
                             pale: buttonModel.shapeShifterIsPale,
                             circle: buttonModel.shapeShifterIsCircle,
                             gray: buttonModel.shapeShifterIsGray)
                    .animation(.linear(duration: shapeShiftTime))
                ZStack {
                    ForEach(buttonModel.diskParameters) { diskParameter in
                        DiskView(precision: diskParameter.precision,
                             down: buttonModel.down,
                             up: buttonModel.up,
                             isSetting: buttonModel.isSetting,
                             isGray: diskParameter.isGray)
                            .padding(radius * CGFloat(diskParameter.relativePadding))
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
