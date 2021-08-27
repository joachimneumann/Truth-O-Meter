//
//  C.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct C {
    static let startAngle = Angle(radians: .pi*2*(0.5+0.11))
    static let endAngle = Angle(radians: .pi*2*(1.0-0.11))
    static let midAngle = Angle(degrees: startAngle.degrees+0.7*(endAngle.degrees-startAngle.degrees))
    static let lineWidth: CGFloat = 7
    static func proportionalAngle(proportion: Double) -> Angle {
        return C.startAngle+(C.endAngle-C.startAngle)*proportion
    }
    static func radius1(rect: CGRect) -> CGFloat { return rect.height * 0.95 }
    static func radius2(rect: CGRect) -> CGFloat { return C.radius1(rect: rect) * 1.07 }
    static func radius3(rect: CGRect) -> CGFloat { return C.radius2(rect: rect) * 1.045 }
    static func displayCenter(rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.midX, y: rect.origin.y + 1.2 * rect.size.height)
    }
    
    struct Timing {
        static let listeningTimeIncrement = 0.02
        static let analyseTimeIncrement = 0.02
    }
    
    struct Sounds {
        static let startRecording:UInt32 = 1113
        static let stopRecording:UInt32 = 1114
        // source: https://github.com/TUNER88/iOSSystemSoundsLibrary
    }
    
    struct Colors {
        static let frameColor = Color(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0)
//        static let bullshitRed = Color(red: 255.0/255.0, green: 126.0/255.0, blue: 121.0/255.0)
        static let bullshitRed = Color(red: 255.0/255.0, green: 83.0/255.0, blue: 77.0/255.0)
        static let paleBullshitRed = Color(red: 255.0/255.0, green: 220.0/255.0, blue: 218.0/255.0)
        static let gray = Color(red:  88/255.0, green: 89/255.0, blue: 82/255.0)
        static let lightGray = Color(red:  188/255.0, green: 189/255.0, blue: 182/255.0)
        static let paleLightGray = Color(red:  210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0)
        static let lightGreen = Color(red:  212/255.0, green: 251/255.0, blue: 121/255.0)
    }
    
    struct UserDefaultKeys {
        static let listenTimingIndex    = "listenTimingIndex"
        static let analysisTimingIndex  = "analysisTimingIndex"
        static let customTitle          = "customTitle"
        static let customEdgeTop        = "customEdgeTop"
        static let customEdgeBottom     = "customEdgeBottom"
        static let customOuterTop       = "customOuterTop"
        static let customOuterBottom    = "customOuterBottom"
        static let customMiddleTop      = "customMiddleTop"
        static let customMiddleBottom   = "customMiddleBottom"
        static let customInnerTop       = "customInnerTop"
        static let customInnerBottom    = "customInnerBottom"
        static let customBullsEyeTop    = "customBullsEyeTop"
        static let customBullsEyeBottom = "customBullsEyeBottom"
    }

}
