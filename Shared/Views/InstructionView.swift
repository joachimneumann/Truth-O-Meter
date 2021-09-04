//
//  Instructions.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 03/09/2021.
//

import SwiftUI
import NavigationStack

struct InstructionView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        ZStack(alignment: .topLeading) {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 20))
                    Text("Back")
                }
                .foregroundColor(.blue)
                .padding(.leading)
                .onTapGesture {
                    self.navigationStack.pop()
                }
            VStack {
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
        .padding(.top, 10)
    }

}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
