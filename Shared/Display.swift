//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @State var target: Target
    var body: some View {
        ZStack {
            DisplayBackground()
            Needle(target: target)
        }
        .aspectRatio(1.9, contentMode: .fit)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Display(target: Target())
        }
    }
}
