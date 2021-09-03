//
//  Instructions.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 03/09/2021.
//

import SwiftUI

struct InstructionView: View {
    @Binding var navigation: NavigationEnum
    var body: some View {
        return VStack {
            VStack {
                Text("Instructions")
                    .font(.title)
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                Image("instructionBullsEye")
                    .resizable()
                    .scaledToFit()
                Text("Tap the center and the needle will go to the left")
                    .padding(.bottom, 50)
                Image("instructionEdge")
                    .resizable()
                    .scaledToFit()
                Text("Tap the edge and the needle will go to the right")
            }
            Spacer()
            VStack {
                Button("OK, I got it") {
                    UserDefaults.standard.setValue(true, forKey: C.key.instructionGiven)
                    navigation = .main
                }
                .padding(.bottom, 5)
                Text("You can see this again in the settings")
                    .foregroundColor(.gray)
                    .font(.subheadline.italic())
            }
        }
        .padding(.top, 20)
        .padding(20)
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView(navigation: .constant(.instructions))
    }
}
