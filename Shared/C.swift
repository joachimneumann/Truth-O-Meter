//
//  C.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

extension Font {
    static var displayTitle: Font { return Font.system(size: C.w * 0.07).bold() }
    static var analyseTitle: Font { return Font.system(size: C.w * 0.04).bold() }
}


struct C {
    #if targetEnvironment(macCatalyst)
    static let w = 375*1.5
    static let h = 667*1.5
    #else
    static let w = UIScreen.main.bounds.width
    static let h = UIScreen.main.bounds.height
    #endif
    
    // the equivialent of linewith 1 on a small device with width 320
    static func lw1(_ geo: GeometryProxy) -> Double {
        geo.size.width / 320.0
    }
    static func lw1() -> Double {
        w / 320.0
    }
    
    static let displayAspectRatio = 1.9

    struct button {
        static let outerRingWidth = 0.03
    }
    
    static var firstTime = true
    
    struct timing {
        static let listeningTimeIncrement  = 0.02
        static let analyseTimeIncrement    = 0.02
        static var shapeShiftAnimationTime: Double {
            get {
                // this is hack, because the view was animated on MacOS
                if firstTime {
                    firstTime = false
                    return 0
                } else {
                    return 0.25
                }
            }
        }
        static let paleAnimationTime       = 0.10
    }
    
    struct sounds {
        static let startRecording:UInt32 = 1113
        static let stopRecording:UInt32 = 1114
        // source: https://github.com/TUNER88/iOSSystemSoundsLibrary
    }
    
    struct color {
        static let frameColor = Color(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0)
        static let bullshitRed = Color(red: 255.0/255.0, green: 83.0/255.0, blue: 77.0/255.0)
        static let paleBullshitRed = Color(red: 255.0/255.0, green: 220.0/255.0, blue: 218.0/255.0)
        static let gray = Color(red:  88/255.0, green: 89/255.0, blue: 82/255.0)
        static let lightGray = Color(red:  188/255.0, green: 189/255.0, blue: 182/255.0)
        static let paleLightGray = Color(red:  210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0)
        static let lightGreen = Color(red:  212/255.0, green: 251/255.0, blue: 121/255.0)
    }
    
    struct key {
        // some key names might seem stange, but this is
        // for compatibility with older app versions
        static let listenTiming         = "fastResponseTimeKey"
        static let analysisTiming       = "analysisTimingIndexkey"
        static let selectedTheme        = "selectedTheme"
        struct custom {
            static let title          = "CustomiseddisplayTextkey"
            struct edge {
                static let top        = "CustomisedfarLeftText1key"
                static let bottom     = "CustomisedfarLeftText2key"
            }
            struct outer {
                static let top       = "CustomisedleftText1key"
                static let bottom    = "CustomisedleftText2key"
            }
            struct middle {
                static let top      = "CustomisedcenterText1key"
                static let bottom   = "CustomisedcenterText2key"
            }
            struct inner {
                static let top       = "CustomisedrightText1key"
                static let bottom    = "CustomisedrightText2key"
            }
            struct bullsEye {
                static let top    = "CustomisedfarRightText1key"
                static let bottom = "CustomisedfarRightText2key"
            }
        }
    }
    
}
