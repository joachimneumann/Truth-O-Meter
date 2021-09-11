//
//  SnapshotViewModel.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/09/2021.
//

import SwiftUI

class SnapshotViewModel: ObservableObject {
    var angle: Angle
    @Published var snapshotTaken: Bool
    var snapshot: UIImage?
    
    func snap(image: UIImage) {
        print("snap()")
        snapshot = image.rotate(radians: Angle(degrees: -25.0).radians)
        snapshotTaken = true
//        let stampPadding = StampPadding(image.size, angle: angle)

    }
    init(angle: Angle) {
        self.angle = angle
        snapshotTaken = false
        snapshot = nil
    }
}

extension UIImage {
    func rotate(radians: Double) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
