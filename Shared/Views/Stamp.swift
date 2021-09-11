//
//  SnapshotView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/09/2021.
//

import SwiftUI

class StampImage: ObservableObject {
    var oldAngle = 0.0
    var angle: Angle
    @Published var snapshot: UIImage?
    
    func snap(image: UIImage) {
        snapshot = image.stampRotate(angle)
    }
    init() {
        self.angle = Angle(degrees: 5)
        snapshot = nil
    }
}

struct Stamp: View {
    var text: String
    var color: Color
    var angle: Double
    let fontSize:CGFloat = 100.0
    @StateObject var snapshotViewModel = StampImage()
    
    var Snapshot: some View {
        let margin      = fontSize * 0.4
        let borderWidth = fontSize * 0.4
        let _ = print("Snapshot angle \(angle)")
        return Text(text)
            .foregroundColor(color)
            .font(.system(size: fontSize))
            .lineLimit(1)
            .padding(margin)
            .padding(borderWidth/2)
            .overlay(
                RoundedRectangle(
                    cornerRadius: borderWidth*1.5)
                    .stroke(color, lineWidth: borderWidth))
            .padding(borderWidth/2)
            .mask(MaskView())
    }
    
    var body: some View {
        if snapshotViewModel.oldAngle != angle {
            snapshotViewModel.oldAngle = angle
            let _ = print("NEW Stamp angle \(angle) oldAngle=\(snapshotViewModel.oldAngle)")
            snapshotViewModel.oldAngle = angle
            snapshotViewModel.angle = Angle(degrees: angle) // angle has not been set in init()
            DispatchQueue.main.async {
                snapshotViewModel.snap(image: Snapshot.stampSnapshot())
            }
        } else {
            let _ = print("OLD Stamp angle \(angle) oldAngle=\(snapshotViewModel.oldAngle)")
        }
        return VStack {
            if let i = snapshotViewModel.snapshot {
                Image(uiImage: i)
                    .resizable()
                    .scaledToFit()
            } else {
                EmptyView()
            }
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(
            text: "BullShit",
            color: C.color.bullshitRed,
            angle: -25.0)
    }
}

extension View {
    func stampSnapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension UIImage {
    func stampRotate(_ angle: Angle) -> UIImage? {
        let newSize =
            CGRect(
                origin: CGPoint.zero,
                size: self.size)
            .applying(
                CGAffineTransform(
                    rotationAngle:
                        CGFloat(angle.radians)))
            .size
        
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        // newSize.width = floor(newSize.width)
        // newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(angle.radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
