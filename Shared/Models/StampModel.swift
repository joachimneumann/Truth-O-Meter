//
//  StampModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 09/09/2021.
//

import SwiftUI

class StampModel: ObservableObject {
    @Published var text: String = "iuhkgiu"
    var frameSize = CGSize(width: 100, height: 100) {
        didSet {
            print("frameSize -> \(frameSize)")
            calc()
        }
    }
    var textSize = CGSize(width: 100, height: 100) {
        didSet {
            print("textSize -> \(textSize)")
            calc()
        }
    }
    @Published var scaleFactor:CGFloat = 1.0
    var largeFontSize:CGFloat = 100

    func calc() {
        print("-------------------------------")
        print("frameSize.width=\(frameSize.width)")
        print("textSize.width=\(textSize.width)")
        let _scaleFactorWidth = frameSize.width / textSize.width
        let _scaleFactorHeight = frameSize.height / textSize.height
        scaleFactor = min(_scaleFactorWidth, _scaleFactorHeight)
        print("scaleFactor=\(scaleFactor)")
    }

}
