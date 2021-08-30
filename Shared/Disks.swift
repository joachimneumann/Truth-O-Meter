//
//  Disks.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct Disks: View {
    @ObservedObject var diskViewModel: DiskViewModel
    private let paleAnimationTime = 0.10
    private let shapeShiftTime = 0.25
    var body: some View {
        GeometryReader { geo in
            let radius = min(geo.size.width, geo.size.height) / 2
            ZStack {
                ShapeShifter(down: diskViewModel.down,
                             up: diskViewModel.up,
                             pale: diskViewModel.shapeShifterIsPale,
                             circle: diskViewModel.shapeShifterIsCircle)
                    .animation(.linear(duration: shapeShiftTime))
                ZStack {
                    ForEach(diskViewModel.diskParameters) { diskParameter in
                        Disk(precision: diskParameter.precision,
                             down: diskViewModel.down,
                             up: diskViewModel.up,
                             isSetting: diskViewModel.isSetting)
                            .padding(radius * CGFloat(diskParameter.relativePadding))
                    }
                }
                // hiding all but the oter ShapeShifter
                .opacity(diskViewModel.disksVisible ? 1.0 : 0.0)
                // this happens without animation. The pale animation happens in the ShapeShifter
            }
        }
    }
}

struct Disks_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        let diskViewModel = DiskViewModel(callback: viewModel.tap)
        Disks(diskViewModel: diskViewModel)
    }
}
