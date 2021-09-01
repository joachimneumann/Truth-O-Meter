//
//  Theme.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 22/08/2021.
//

import Foundation



struct Theme: Identifiable, Equatable {
    private(set) var id: Int

    var title: String {
        didSet {
            UserDefaults.standard.set(title, forKey: C.key.custom.title)
        }
    }
    
    mutating func setTitle(_ newTitle: String) {
        title = newTitle
    }

    func top(forPrecision precision: Precision) -> String {
        switch precision {
        case .edge:
            return edge.top
        case .outer:
            return outer.top
        case .middle:
            return middle.top
        case .inner:
            return inner.top
        case .bullsEye:
            return bullsEye.top
        }
    }
    
    func bottom(forPrecision precision: Precision) -> String? {
        switch precision {
        case .edge:
            return edge.bottom
        case .outer:
            return outer.bottom
        case .middle:
            return middle.bottom
        case .inner:
            return inner.bottom
        case .bullsEye:
            return bullsEye.bottom
        }
    }

    
    struct StampTexts {
        var top: String
        var bottom: String?
        init(_ top_: String, _ bottom_: String?) { top = top_; bottom = bottom_ }
    }

    var edge: StampTexts
    var outer: StampTexts
    var middle: StampTexts
    var inner: StampTexts
    var bullsEye: StampTexts
    var isCustomisable: Bool

    mutating func setTop(_ newTop: String, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            edge.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.edge.top) }
        case .outer:
            outer.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.outer.top) }
        case .middle:
            middle.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.middle.top) }
        case .inner:
            inner.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.inner.top) }
        case .bullsEye:
            bullsEye.top = newTop
            if isCustomisable { UserDefaults.standard.set(newTop, forKey: C.key.custom.bullsEye.top) }
        }
    }
    
    mutating func setBottom(_ newBottom: String?, forPrecision: Precision) {
        switch forPrecision {
        case .edge:
            edge.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.edge.bottom) }
        case .outer:
            outer.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.outer.bottom) }
        case .middle:
            middle.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.middle.bottom) }
        case .inner:
            inner.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.inner.bottom) }
        case .bullsEye:
            bullsEye.bottom = newBottom
            if isCustomisable { UserDefaults.standard.set(newBottom, forKey: C.key.custom.bullsEye.bottom) }
        }
    }

    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
    
}
