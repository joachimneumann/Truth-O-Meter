//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI

struct Stamp: View {
    var text: String
    var body: some View {
        HorizontalStampText(text: text)
    }
    
    struct HorizontalStampText: View {
        var text: String
        let largeFontSize:CGFloat = 300
        @State var frameSize = CGSize(width: 100, height: 100)
        @State var textSize = CGSize(width: 100, height: 100)
        var scaleFactor : CGFloat {
            let _scaleFactorWidth = frameSize.width / textSize.width
            let _scaleFactorHeight = frameSize.height / textSize.height
            return min(_scaleFactorWidth, _scaleFactorHeight)
        }
        
        @State private var name = ""
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue.opacity(0.2))
                    .stampCaptureSize(in: $frameSize)
                    .background(
                        ZStack {
                            Text(text)
                                .background(Color.blue.opacity(0.2))
                                .font(.system(size: largeFontSize))
                                .fixedSize()
                                .stampCaptureSize(in: $textSize)
                                .hidden()
                            Text(text)
                                .font(.system(size: largeFontSize))
                                .fixedSize()
                                .background(Color.green)
                                .scaleEffect(scaleFactor, anchor: .center)
                        }
                    )
            }
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(text: "Éjsdf")
            .frame(width: 250, height: 250, alignment: .center)
            .background(Color.yellow.opacity(0.2))
            .border(Color.black)
    }
}



