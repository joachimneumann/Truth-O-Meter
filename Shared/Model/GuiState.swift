//
//  GuiState.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import Foundation


enum GuiStateEnum {
    case waiting, listening, doneListening, analysing, showingResult
}

class GuiState: ObservableObject {
    @Published var state: GuiStateEnum = .waiting
    func newState(state: GuiStateEnum) {
        self.state = state
        print("GuiState -> \(state)")
    }
}
