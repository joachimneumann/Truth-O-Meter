//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    var body: some View {
        VStack {
            ZStack {
                DisplayBackground()
                Needle()
            }
            .aspectRatio(1.9, contentMode: .fit)
            Spacer()
            TrueButton()
                .padding(.all)
        }
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Display()
        }
    }
}