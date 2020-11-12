//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    @ObservedObject var truth: Truth
    var body: some View {
        ZStack {
            DisplayBackground()
            Needle(truth: truth)
        }
        .aspectRatio(1.9, contentMode: .fit)
    }
}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Display(truth: Truth())
    }
}
