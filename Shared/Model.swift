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
    private(set) var displayActive: Bool = false
    private(set) var state: State
    private(set) var truth = 0.5
    
    mutating func setState(_ s: State) {
        state = s
        if (state == .wait || state == .listen) {
            displayActive = false
        } else {
            displayActive = true
        }
    }
    
    init() {
        self.state = .wait
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
