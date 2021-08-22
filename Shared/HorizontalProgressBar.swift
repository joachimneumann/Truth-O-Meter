//
//  HorizontalProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 20/08/2021.
//

import Foundation
import SwiftUI

struct HorizontalProgressBar: View {
    var value:CGFloat
    var body: some View {
        ZStack { //(alignment: .leading) {
            GeometryReader { (geo) in
                Rectangle()
                    .foregroundColor(C.Colors.lightGray)
                Rectangle()
                    .foregroundColor(C.Colors.bullshitRed)
                    .frame(width:geo.size.width*value, height: geo.size.height)
            }
        }
        .aspectRatio(20.0, contentMode: .fit)
    }
}

struct HorizontalProgressbar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressBar(value: 0.8)
            .padding()
    }
}
