//
//  Theme.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 22/08/2021.
//

import Foundation

struct StampTexts {
    var top: String
    var bottom: String?
    init(_ top_: String, _ bottom_: String?) { top = top_; bottom = bottom_ }
}

struct Results {
    var edge: StampTexts
    var outer: StampTexts
    var middle: StampTexts
    var inner: StampTexts
    var bullsEye: StampTexts
}


class Theme: Identifiable, Equatable {
    private(set) var id: Int
    private(set) var results: Results
    var isCustomisable: Bool
        
    @Published var title: String { // public, because we use @Binding in DisplayView
            didSet {
                UserDefaults.standard.set(title, forKey: C.key.custom.title)
            }
        }
    
    func setTop(_ newTop: String, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            results.edge.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.edge.top) }
        case .outer:
            results.outer.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.outer.top) }
        case .middle:
            results.middle.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.middle.top) }
        case .inner:
            results.inner.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.inner.top) }
        case .bullsEye:
            results.bullsEye.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.bullsEye.top) }
        }
    }

    func setBottom(_ newBottom: String?, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            results.edge.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.edge.bottom) }
        case .outer:
            results.outer.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.outer.bottom) }
        case .middle:
            results.middle.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.middle.bottom) }
        case .inner:
            results.inner.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.inner.bottom) }
        case .bullsEye:
            results.bullsEye.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.bullsEye.bottom) }
        }
    }

    func result(forPrecision precision: Precision) -> StampTexts {
        switch precision {
        case .edge:
            return results.edge
        case .outer:
            return results.outer
        case .middle:
            return results.middle
        case .inner:
            return results.inner
        case .bullsEye:
            return results.bullsEye
        }
    }
    init(index: Int, title: String, results: Results, isCustomisable: Bool = false) {
        self.id = index
        self.title = title
        self.results = results
        self.isCustomisable = isCustomisable
    }
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
    
}
