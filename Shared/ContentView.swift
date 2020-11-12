//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var truth: Truth
    var body: some View {
        VStack {
            Display(truth: truth)
            Spacer()
            TrueButton(truth: truth)
//            TrueButton() { value in
//                truth.newTruth(updateTo: value)
//            }
            .padding(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(truth: Truth())
    }
}
