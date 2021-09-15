//
//  Instructions.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 03/09/2021.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center) {
                Image("instructionBullsEye")
                    .resizable()
                    .scaledToFit()
                Text("Tap the center and the needle will go to the left")
                    .italic()
                    .padding(.bottom, 50)
                Image("instructionEdge")
                    .resizable()
                    .scaledToFit()
                Text("Tap the edge and the needle will go to the right")
                    .italic()
            }
            .padding()
            Spacer()
        }
        .padding(.top, 40)
        Spacer()
    }    
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
