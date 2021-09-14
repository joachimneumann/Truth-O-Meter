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
        print("XXXXXXXXXXX size=\(value)")
        value = nextValue()
    }
}

extension View {
    func captureSize(in binding: Binding<CGSize>, description: String, captured: inout Bool, capturedBinding: Binding<Bool>) -> some View {
        let _ = print("\(description) captured=\(captured) \(capturedBinding.wrappedValue)")
        captured = true
        capturedBinding.wrappedValue = true
        return overlay(GeometryReader { proxy in
            // let _ = print("\(description): Color.clear.preference size=\(proxy.size)")
            Color.clear.preference(key: StampSizeKey.self, value: proxy.size)
        })
            .onPreferenceChange(StampSizeKey.self) { size in
                print("\(description): onPreferenceChange size=\(size)")
                DispatchQueue.main.async {
                    binding.wrappedValue = size
                    capturedBinding.wrappedValue = false
                }
            }
    }
}
