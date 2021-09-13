//
//  SnapshotView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/09/2021.
//

import SwiftUI


class StampImage: ObservableObject {
    var angle: Angle
    @Published var snapshot: UIImage?
    
    init() {
        self.angle = Angle(degrees: 5)
        snapshot = nil
    }
        
    func snap(image: UIImage, borderWidth: Double, cornerRadius: Double) {
        let rotatedImage = image.stampRotate(angle)
        
        let outerCornerRadius = cornerRadius + 0.5 * borderWidth
        let _45radiants = Angle(degrees: 45).radians
        let x1 = cos(_45radiants - abs(angle.radians))
        let x2 = sqrt(2)*x1 - 1
        let crop = x2 * outerCornerRadius
        let cropRect = CGRect(
            x: crop * rotatedImage.scale,
            y: crop * rotatedImage.scale,
            width:  (rotatedImage.size.width  - 2 * crop) * rotatedImage.scale,
            height: (rotatedImage.size.height - 2 * crop) * rotatedImage.scale
        )
        
        let cgImage = rotatedImage.cgImage!
        let croppedCGImage = cgImage.cropping(
            to: cropRect
        )!
        
        let croppedImage = UIImage(
            cgImage: croppedCGImage,
            scale: image.imageRendererFormat.scale,
            orientation: image.imageOrientation
        )
        snapshot = croppedImage
    }
}

struct Stamp: View {
    var top: String
    var bottom: String?
    var color: Color
    var angle: Angle
    let fontSize = 100.0
    @StateObject var stampImage = StampImage()
    
    var cornerRadius: Double {
        fontSize * 0.4*1.5
    }
    var borderWidth: Double {
        fontSize * 0.4 * 1.5
    }
    var margin: Double {
        fontSize * 0.4
    }
    
    var HorizontalStamp: some View {
        Group {
            if let bottom = bottom {
                VStack {
                    Text(top)
                        .foregroundColor(color)
                        .font(.system(size: fontSize))
                        .lineLimit(1)
                    Text(bottom)
                        .foregroundColor(color)
                        .font(.system(size: fontSize))
                        .lineLimit(1)
                }
                .padding(margin)
                .padding(borderWidth/2)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: cornerRadius)
                        .stroke(color, lineWidth: borderWidth))
                .padding(borderWidth/2)
                .mask(MaskView())
            } else {
                Text(top)
                    .foregroundColor(color)
                    .font(.system(size: fontSize))
                    .lineLimit(1)
                    .padding(margin)
                    .padding(borderWidth/2)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: cornerRadius)
                            .stroke(color, lineWidth: borderWidth))
                    .padding(borderWidth/2)
                    .mask(MaskView())
            }
        }
    }
    
    var body: some View {
        if stampImage.angle != angle {
            stampImage.angle = angle
            DispatchQueue.main.async {
                stampImage.snap(image: HorizontalStamp.stampSnapshot(), borderWidth: borderWidth, cornerRadius: cornerRadius)
            }
        }
        return ZStack {
            if let snapshot = stampImage.snapshot {
                Image(uiImage: snapshot)
                    .resizable()
                    .scaledToFit()
                    .clipped()
            } else {
                EmptyView()
            }
        }
        //.background(Color.green.opacity(0.2))
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
    func stampRotate(_ angle: Angle) -> UIImage {
        let newSize =
            CGRect(
                origin: CGPoint.zero,
                size: self.size)
            .applying(
                CGAffineTransform(
                    rotationAngle: angle.radians))
            .size
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        /// Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        /// Rotate around middle
        context.rotate(by: Double(angle.radians))
        /// Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        Stamp(
            top: "Absolute",
            bottom: "BullShit",
            color: C.color.bullshitRed,
            angle: Angle(degrees: -25.0))
        }
    }
}
