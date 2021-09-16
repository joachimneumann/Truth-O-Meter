////
////  InnerButton.swift
////  Truth-O-Meter (iOS)
////
////  Created by Joachim Neumann on 16/09/2021.
////
//
//import SwiftUI
//
//struct InnerButton: View {
//    let radius: Double
//    let color: Color
//    let paleColor: Color
//    let settingsMode: Bool
//    @State private var tapped = false
//    func down() {
////        print("down")
////        if !tapped {
////        DispatchQueue.main.async {
////        }
//////            print("down() tapped=\(tapped) pale=\(pale)")
////        }
//    }
//    func up(_ precision: Precision) {
////        print("up")
////        DispatchQueue.main.async {
////            pale = false
////        }
//        tapped = true
//////        print("up() tapped=\(tapped) pale=\(pale)")
//    }
//    var body: some View {
//        ZStack {
//            if !settingsMode {
//                ShapeShifter(
//                    radius: radius,
//                    color: C.color.bullshitRed,
//                    isCircle: !tapped)
//            }
//            if settingsMode || !tapped {
//                FiveDisks(
//                    radius: radius,
//                    color: C.color.bullshitRed,
//                    paleColor: C.color.paleBullshitRed,
//                    settingsMode: settingsMode,
//                    callback: up)
//            }
//        }
//    }
//}
//
//struct InnerButton_Previews: PreviewProvider {
//    static var previews: some View {
//        func ff(_ precision: Precision) {
//            print(precision)
//        }
//        return InnerButton(
//            radius: 100,
//            color: Color.green.opacity(0.2),
//            paleColor: C.color.paleBullshitRed,
//            settingsMode: true)
//    }
//}
