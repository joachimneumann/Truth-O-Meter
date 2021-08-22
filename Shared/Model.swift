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

    private(set) var displayTitle = "Truth-O-Meter"
    private(set) var displayActive: Bool = true
    private(set) var state: State = .wait
    private(set) var truth = 0.5
    
    private enum TimingEnum {
        case fast, medium, slow
    }
    
    private var listenTiming: TimingEnum = .medium
    private var analysisTiming: TimingEnum = .medium

    var listenTime: Double {
        get {
            switch listenTiming {
            case .fast:
                return 10.0
            case .medium:
                return 6.0
            case .slow:
                return 2.0
            }
        }
    }
    var analysisTime: Double {
        get {
            switch analysisTiming {
            case .fast:
                return 10.0
            case .medium:
                return 6.0
            case .slow:
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
            displayActive = true
        } else {
            displayActive = true
        }
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
