//
//  SmartButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct SmartButton: View {
    @ObservedObject var buttonModel: ButtonModel
    var body: some View {
        GeometryReader { geo in
            let w = min(geo.size.width, geo.size.height)
            let linewidth = w * C.button.outerRingWidth
            if buttonModel.isShowingStamp {
                Stamp(texts: buttonModel.result)
                    .onTapGesture {
                        buttonModel.startOver()
                    }
            } else if buttonModel.isAnalysing {
                EmptyView()
            } else if buttonModel.isListening {
                ZStack {
                    RingView(width: linewidth, totalTime: 2, callback: buttonModel.listeningFinished)
                    AllDisksView(isSetting: false, callback: buttonModel.buttonPressedWith)
                        .padding(linewidth * 1.5)
                }
            } else {
                ZStack {
                    Circle()
                        .stroke(C.color.lightGray, lineWidth: linewidth)
                    AllDisksView(isSetting: false, callback: buttonModel.buttonPressedWith)
                        .padding(linewidth * 1.5)
                }
            }
        }
    }
}

struct SmartButton_Previews: PreviewProvider {
    static var previews: some View {
        let buttonModel = ButtonModel(isSetting: false)
        SmartButton(buttonModel: buttonModel)
    }
}
