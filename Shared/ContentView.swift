//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var target: Target
    
    var body: some View {
        VStack {
            Display(target: target)
            Spacer()
            TrueButton() { newLongTermValue in
                print("ContentView: \(newLongTermValue)")
                target.longTerm = newLongTermValue
            }
            .padding(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(target: Target())
    }
}
