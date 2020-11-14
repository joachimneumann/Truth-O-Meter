//
//  GuiState.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import Foundation


enum GuiStateEnum {
    case wait, listen, analyse, show
}

class GuiState: ObservableObject {
    @Published var state: GuiStateEnum = .wait
    init(state: GuiStateEnum) {
        self.state = state
    }
    func newState(state: GuiStateEnum) {
        self.state = state
        print("GuiState -> \(state)")
    }
}
