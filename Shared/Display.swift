//
//  Display.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct Display: View {
    var isOn: Bool
    var body: some View {
        if (isOn) {
            Text("Display: On")
        } else {
            Text("Display Off")
        }
//        VStack {
//            ZStack {
//                DisplayBackground()
//                Needle()
//            }
//            .aspectRatio(1.9, contentMode: .fit)
//        }
    }
    func isOn(value: Bool) {
        
    }

}

struct Display_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Display(isOn: true)
        }
    }
}
