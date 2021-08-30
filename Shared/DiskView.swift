//
//  DiskView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct DiskView: View {
    @Binding var superViewIsPale: Bool
    @Binding var isHidden: Bool
    @Binding var drawBorder: Bool
    @Binding var isGray: Bool
    var up: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .fill(isGray ? C.color.lightGray : C.color.bullshitRed)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isHidden {
                                superViewIsPale = true
                                print("Disk down isHidden = \(isHidden)")
                                isHidden = true
                            }
                        }
                        .onEnded { _ in
                            print("Disk up")
                            up()
                        }
                )
                .opacity(superViewIsPale || isHidden ? 0.0 : 1.0)
            // border
            if drawBorder {
                Circle()
                    .stroke(C.color.lightGray, lineWidth: 1)
            }
        }
    }
}

struct Disk_Previews: PreviewProvider {
    static var previews: some View {
        @State var buttonModel = ButtonModel(isSetting: false)
        return DiskView(
            superViewIsPale: $buttonModel.isSetting,
            isHidden: $buttonModel.shapeShifterIsPale,
            drawBorder: $buttonModel.isSetting,
            isGray: $buttonModel.isSetting) {
//            $buttonModel.buttonPressedWith(.middle)
        }
    }
}
