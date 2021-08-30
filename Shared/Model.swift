//
//  AppState.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import Foundation


struct Model {
    enum State {
        case wait, listen, analyse, show, settings
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
            case .settings:
                return "settings"
            }
        }
    }

    private(set) var state: State = .wait
    
    mutating func setState(_ s: State) {
        state = s
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
 
 
 
 #if swift(>=5.8)
 print("Hello, Swift 5.8")

 #elseif swift(>=5.7)
 print("Hello, Swift 5.7")

 #elseif swift(>=5.6)
 print("Hello, Swift 5.6")

 #elseif swift(>=5.5)
 print("Hello, Swift 5.5")

 #elseif swift(>=5.4)
 print("Hello, Swift 5.4")

 #elseif swift(>=5.3)
 print("Hello, Swift 5.3")

 #elseif swift(>=5.2)
 print("Hello, Swift 5.2")

 #elseif swift(>=5.1)
 print("Hello, Swift 5.1")

 #elseif swift(>=5.0)
 print("Hello, Swift 5.0")

 #elseif swift(>=4.2)
 print("Hello, Swift 4.2")

 #elseif swift(>=4.1)
 print("Hello, Swift 4.1")

 #elseif swift(>=4.0)
 print("Hello, Swift 4.0")

 #elseif swift(>=3.2)
 print("Hello, Swift 3.2")

 #elseif swift(>=3.0)
 print("Hello, Swift 3.0")

 #elseif swift(>=2.2)
 print("Hello, Swift 2.2")

 #elseif swift(>=2.1)
 print("Hello, Swift 2.1")

 #elseif swift(>=2.0)
 print("Hello, Swift 2.0")

 #elseif swift(>=1.2)
 print("Hello, Swift 1.2")

 #elseif swift(>=1.1)
 print("Hello, Swift 1.1")

 #elseif swift(>=1.0)
 print("Hello, Swift 1.0")

 #endif
*/
