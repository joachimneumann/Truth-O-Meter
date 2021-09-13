//
//  CaptureSize.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 09/09/2021.
//

import SwiftUI

private struct StampSizeKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func captureSize(in binding: Binding<CGSize>) -> some View {
        overlay(GeometryReader { proxy in
            let _ = print("Color.clear.preference")
            Color.clear.preference(key: StampSizeKey.self, value: proxy.size)
        })
            .onPreferenceChange(StampSizeKey.self) { size in
                binding.wrappedValue = size
                print("onPreferenceChange")
            }
    }
}
