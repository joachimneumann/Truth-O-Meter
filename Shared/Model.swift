//
//  AppState.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import Foundation


struct Model {
    enum State {
        case wait, listen, analyse, show
    }

    private(set) var displayActive: Bool = true
    private(set) var state: State = .wait
    private(set) var truth = 0.5
    
    private enum TimingEnum {
        case fast, medium, slow
    }
    
    private var listenTiming: TimingEnum = .fast
    private var analysisTiming: TimingEnum = .fast

    var theme:Theme
    
    private let bullshitTheme = Theme(
        displayText: "Bullshit-O-Meter",
        farRight: StampTexts("Absolute", "Bullshit"),
        right:    StampTexts("Bullshit", nil),
        center:   StampTexts("undecided", nil),
        left:     StampTexts("Mostly", "True"),
        farLeft:  StampTexts("True", nil))
        
    var listenTime: Double {
        get {
            switch listenTiming {
            case .slow:
                return 10.0
            case .medium:
                return 6.0
            case .fast:
                return 2.0
            }
        }
    }
    
    var analysisTime: Double {
        get {
            switch analysisTiming {
            case .slow:
                return 10.0
            case .medium:
                return 6.0
            case .fast:
                return 2.0
            }
        }
    }
    var listenAndAnalysisTime: Double {
        get { listenTime + analysisTime }
    }

    mutating func setTruth(_ t: Double) {
        truth = t
    }
    
    mutating func setState(_ s: State) {
        state = s
        if (state == .wait) {
            displayActive = false
        } else {
            displayActive = true
        }
    }
    
    init() {
        theme = bullshitTheme
    }

}


/*

 wait
 ====
 (initial state and when coming back frm settings)
 display gray
 needle gray, not moving
 button round, red
 next state --> listen
 
 listen
 ======
 start sound
 display gray
 needle gray, not moving
 button rectangle, red, circle animated to close
 end sound
 next state --> analyse
 
 
 analyse
 =======
 display color
 needle red, moving towards target
 button invisible circle invisible
 full circle green slowly filling
 next state --> show

 
 show
 ====
 display color
 needle red, moving on target
 button round, red
 next state --> listen
 
*/
