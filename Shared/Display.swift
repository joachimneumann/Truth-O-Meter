//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @State var isActive: Bool
    let title: String
    var body: some View {
        ZStack {
            DisplayBackground(isGrayedOut: !isActive)
            Text(title)
                .offset(y: 15)
                .foregroundColor(isActive ? C.Colors.gray : C.Colors.lightGray)
                .font(.headline)
            Needle(isVisible: isActive)
                .clipped()
        }
        .aspectRatio(1.9, contentMode: .fit)
        .padding(30)
        .padding(.top, 10)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Display(isActive: true, title: "active")
            Display(isActive: false, title: "not active")
        }
    }
}
