//
//  TrueButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI
import AudioToolbox// <AudioToolbox/AudioToolbox.h>
import AVFoundation

class TruthButtonWidth: ObservableObject {
    @Published var value: CGFloat = 0.0
}

struct TrueButton: View {
//    @EnvironmentObject var guiState: GuiState
//    @ObservedObject var nextTarget: NextTarget
//    @ObservedObject var truthButtonWidth: TruthButtonWidth
    var isActive: Bool
    let title: String
    
    var body: some View {
        return SwiftUI.GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }
    
    func makeView(geometry: GeometryProxy) -> some View {
//        let tapGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({
//            if isActive {
//let nc = NotificationCenter.default
//let x = 0.9
//nc.post(name: Notification.Name("newTarget"), object: x)

//                var relativeTap: Double = Double($0.startLocation.x / truthButtonWidth.value)
//                if relativeTap < 0.0 { relativeTap = 0.0 }
//                if relativeTap > 1.0 { relativeTap = 1.0 }
//                 print("\($0.startLocation.x) in \(truthButtonWidth.value) --> \(relativeTap)")
//                nextTarget.value = relativeTap
//                withAnimation(.easeInOut(duration: 0.5)) {
//                    guiState.newState(state: GuiStateEnum.listen)
//                }
//            }
//        }
            DispatchQueue.main.async {
//                self.rect = geometry.frame(in: .global)
            }

            return Rectangle().fill(Color.clear)
        }
    
//    func makeView(geometry: GeometryProxy) -> some View {
//        return Rectangle().fill(Color.clear)
//        return ZStack {
//            // This hack allows me to set truthButtonWidth after the view
//            // has been laid out and after every window resize (on the Mac)
////            Path { path in
////                if abs(truthButtonWidth.value - geo.size.width) > 1.0 {
////                    truthButtonWidth.value = geo.size.width
////                    print("new width \(truthButtonWidth.value) \(geo.size.width)")
////                }
////            }
//            Text(title)
//                .font(.system(size: 24, design: .monospaced))
//                .fontWeight(.bold)
//                .aspectRatio(contentMode: .fill)
//                .foregroundColor(.white)
//            // Hack needed here because
//            // - Tab events are not triggered in GeometryReader
//            // - Tab events are not triggered views with opacity zero
//            Rectangle()
//                .foregroundColor(Color.orange.opacity(0.00000001))
//        }
//        .gesture(tapGesture)
//    }
    
//
//        GeometryReader { geo in
//            ZStack{
//                // This hack allows me to set truthButtonWidth after the view
//                // has been laid out and after every window resize (on the Mac)
//                Path { path in
//                    if abs(truthButtonWidth.value - geo.size.width) > 1.0 {
//                        truthButtonWidth.value = geo.size.width
//                        print("new width \(truthButtonWidth.value) \(geo.size.width)")
//                    }
//                }
//                Text(title)
//                    .font(.system(size: 24, design: .monospaced))
//                    .fontWeight(.bold)
//                    .aspectRatio(contentMode: .fill)
//                    .foregroundColor(.white)
//                // Hack needed here because
//                // - Tab events are not triggered in GeometryReader
//                // - Tab events are not triggered views with opacity zero
//                Rectangle()
//                    .foregroundColor(Color.orange.opacity(0.00000001))
//            }
//            .gesture(tapGesture)
//        }
//        .background(isActive ? C.Colors.bullshitRed : C.Colors.lightGray)
//        .cornerRadius(15)
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
//        .padding (.all, 20)
//    }
    
}



//struct TrueButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TrueButton(nextTarget: NextTarget(), truthButtonWidth: TruthButtonWidth(), title: "button title")
//            .environmentObject(GuiState(state: .wait))
//    }
//}
