//
//  CaptureSize.swift
//  Truth-O-Meter
//
//  from https://newbedev.com/swiftui-rotationeffect-framing-and-offsetting
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
        return overlay(GeometryReader { proxy in
            Color.clear.preference(key: StampSizeKey.self, value: proxy.size)
        })
            .onPreferenceChange(StampSizeKey.self) { size in
                DispatchQueue.main.async {
                    binding.wrappedValue = size
                }
            }
    }
}
