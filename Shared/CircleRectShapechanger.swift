//
//  CircleRectShapechanger.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 29/08/2021.
//

import SwiftUI

struct CircleRectShapechanger: View {
    @State private var circle = true
    @State private var opaque = true
    
    struct InnerCircleRectShapechanger: View {
        var circle: Bool
        var body: some View {
            GeometryReader { (geo) in
                let w: CGFloat = min(geo.size.height, geo.size.width)
                Rectangle()
                    .cornerRadius(circle ? w/2 : w/14)
                    .padding(circle ? 0 : w/4)
                    .animation(.linear(duration: 0.25))
                    .foregroundColor(C.color.bullshitRed)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }

    var body: some View {
        VStack {
            VStack {
                InnerCircleRectShapechanger(circle: circle)
                    .opacity(opaque ? 1.0: 0.3)
                    .animation(.linear(duration: 0.1))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                if opaque {
                                    print("down")
                                    opaque = false
                                }
                            }

                            .onEnded { _ in
                                print("up")
                                opaque = true
                                circle.toggle()
                            }
                    )
            }
            .padding(100)
        }
    }
}

struct CircleRectShapechanger_Previews: PreviewProvider {
    static var previews: some View {
        CircleRectShapechanger()
            .padding(100)
    }
}

