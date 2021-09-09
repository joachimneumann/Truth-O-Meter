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
        var stampModel: StampModel
        @State private var frameSize = CGSize(width: 100, height: 100)
        @State private var textSize = CGSize(width: 100, height: 100)
        private let unscaledFontSize:CGFloat = 300
        
        var body: some View {
            ZStack {
                GeometryReader { geo in
                    Rectangle()
                        .foregroundColor(.blue.opacity(0.1))
                        .stampCaptureSize(in: $frameSize)
                    Text(stampModel.text)
                        .font(.system(size: unscaledFontSize))
                        .fixedSize()
                        .background(
                            GeometryReader { (geo) -> Color in
                                DispatchQueue.main.async {
                                    textSize = geo.size
                                }
                                return Color.clear
                            }
                        )
                        .hidden()
                    Text(stampModel.text)
                        .font(.system(size: unscaledFontSize * frameSize.width / textSize.width))
                    .fixedSize()
                }
            }
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(stampModel: StampModel())
            .frame(width: 300, height: 300, alignment: .center)
            .border(Color.black)
    }
}

