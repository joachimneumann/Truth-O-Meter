//
//  CPImage.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 21/08/2021.
//

// cross platform image for macOS and iOS
// from https://www.alfianlosari.com/posts/building-cross-platform-swiftui-ios-macos-app/

import SwiftUI

#if os(iOS)
    import UIKit
    public typealias CPImage = UIImage
#elseif os(macOS)
    import AppKit
    public typealias CPImage = NSImage
#endif

extension CPImage {
    var coreImage: CIImage? {
        #if os(iOS)
        guard let cgImage = self.cgImage else {
            return nil
        }
        return CIImage(cgImage: cgImage)
        #elseif os(macOS)
        guard
            let tiffData = tiffRepresentation,
            let ciImage = CIImage(data: tiffData)
            else {
                return nil
        }
        return ciImage
        #endif
    }
    
    func text(_ s: String) -> CPImage {
        return self
    }
}

extension CGImage {
    var cpImage: CPImage {
        #if os(iOS)
        return UIImage(cgImage: self)
        #elseif os(macOS)
        return NSImage(cgImage: self, size: .init(width: width, height: height))
        #endif
    }
}

extension Image {
    init(cpImage: CPImage) {
        #if os(iOS)
        self.init(uiImage: cpImage)
        #elseif os(macOS)
        self.init(nsImage: cpImage)
        #endif
    }
}
