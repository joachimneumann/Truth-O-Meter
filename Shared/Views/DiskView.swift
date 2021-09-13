//
//  DiskView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct DiskView: View {
    var isOpaque: Bool
    var borderWidth: Double
    var isGray: Bool
    var down: () -> Void
    var up: () -> Void
    
    let color: Color
    let grayColor: Color
    
    @State private var isDown = false
    var body: some View {
        ZStack {
            Circle()
                .fill(isGray ? grayColor : color)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isDown {
                                isDown = true
                                down()
                            }
                        }
                        .onEnded { _ in
                            if isDown {
                                isDown = false
                                up()
                            }
                        }
                )
                .opacity(isOpaque ? 1.0 : 0.0)
            // border
            if borderWidth > 0 && isOpaque {
                Circle()
                    .stroke(grayColor, lineWidth: borderWidth)
            }
        }
    }
}

struct Disk_Previews: PreviewProvider {
    static var previews: some View {
        func f() {}
        return DiskView(
            isOpaque: true,
            borderWidth: 20.0,
            isGray: false,
            down: f,
            up: f,
            color: C.color.bullshitRed,
            grayColor: C.color.lightGray)
    }
}

