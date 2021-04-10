//
//  AppState.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import Foundation


class Model {
    enum StateEnum {
        case wait, listen, analyse, show
        func description() -> String {
            switch self {
            case .wait:
                return "wait"
            case .listen:
                return "listen"
            case .analyse:
                return "analyse"
            case .show:
                return "show"
            }
        }
    }
    
    var value:StateEnum {
        didSet {
            switch value {
            case .wait:
                print("wait")
            case .listen:
                print( "listen")
            case .analyse:
                print( "analyse")
            case .show:
                print( "show")
            }
        }
    }
    
    init() {
        self.value = .wait
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
