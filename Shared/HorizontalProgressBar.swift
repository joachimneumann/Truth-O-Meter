//
//  HorizontalProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 20/08/2021.
//

import Foundation
import SwiftUI

struct HorizontalProgressBar: View {
    let color: Color
    var value:CGFloat
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            GeometryReader { (geo) in
                Rectangle()
                    .frame(width:geo.size.width, height: geo.size.height)
                    .foregroundColor(C.Colors.lightGray)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0)
                Rectangle()
                    .frame(width:geo.size.width*value, height: geo.size.height)
                    .foregroundColor(color)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 0)
            }
        })
    }
    
    func getPercentage(_ value:CGFloat) -> String {
        let intValue = Int(ceil(value * 100))
        return "\(intValue) %"
    }
}

struct HorizontalProgressbar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressBar(color: C.Colors.bullshitRed, value: 0.8)
            .frame(width: 200, height: 25, alignment: .center)
    }
}
