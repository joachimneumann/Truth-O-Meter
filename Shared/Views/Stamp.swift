//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI

struct Stamp: View {
    var stampModel: StampModel
    
    var body: some View {
        HorizontalStampText(stampModel: stampModel)
    }
    
    struct HorizontalStampText: View {
        @ObservedObject var stampModel: StampModel
        
        var scaledFontSize:CGFloat = 20.0
        
        @State private var name = ""
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue.opacity(0.2))
                    .stampCaptureSize(in: $stampModel.frameSize)
                    .background(
                        ZStack {
                            Text(stampModel.text)
                                .background(Color.blue.opacity(0.2))
                                .font(.system(size: stampModel.largeFontSize))
                                .fixedSize()
                                .stampCaptureSize(in: $stampModel.textSize)
                                .hidden()
                            Text(stampModel.text)
                                .font(.system(size: stampModel.largeFontSize))
                                .fixedSize()
                                .background(Color.green)
                                .scaleEffect(stampModel.scaleFactor, anchor: .center)
                        }
                    )
            }
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(stampModel: StampModel())
            .frame(width: 250, height: 250, alignment: .center)
            .background(Color.yellow.opacity(0.2))
            .border(Color.black)
    }
}



