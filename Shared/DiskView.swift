//
//  DiskView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct DiskView: View {
    var isOpaque: Bool
    var drawBorder: Bool
    var isGray: Bool
    var down: () -> Void
    var up: () -> Void
    
    private let borderColor = C.color.lightGray
    private let color = C.color.bullshitRed
    private let grayColor = C.color.lightGray
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isGray ? grayColor : color)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            print("Disk down")
                            down()
                        }
                        .onEnded { _ in
                            print("Disk up")
                            up()
                        }
                )
                .opacity(isOpaque ? 1.0 : 0.0)
            // border
            if drawBorder {
                Circle()
                    .stroke(borderColor, lineWidth: 1)
            }
        }
    }
}

struct Disk_Previews: PreviewProvider {
    static var previews: some View {
        func f() {}
        return DiskView(
            isOpaque: false,
            drawBorder: false,
            isGray: false,
            down: f,
            up: f)
    }
}

