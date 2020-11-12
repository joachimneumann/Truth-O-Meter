//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var isOn = false
    
    var body: some View {
        VStack {
            Display(isOn: isOn)
//            Toggle(isOn: $isOn) {  }
            Button(action: { self.isOn.toggle() }) {
                self.isOn ? Text("Turn Off") : Text("Turn On")
            }
        }
    }
}
//
//struct ContentView: View {
//    @State var isOn = false
//
//    var body: some View {
//        VStack {
//            Display()
//                .newTarget(isOn: isOn)
//            Spacer()
//            TrueButton() {x in
//                isOn = x
//                print("Detail selected: \(x)")
//            }
//                .padding(.all)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
