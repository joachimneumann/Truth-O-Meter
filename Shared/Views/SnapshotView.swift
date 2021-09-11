//
//  SnapshotView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/09/2021.
//

import SwiftUI

struct SnapshotView: View {
    @StateObject var snapshotViewModel = SnapshotViewModel()
    var text: String
    var color: Color
    let fontSize:CGFloat
    var angle: Angle
    
    @State var size: CGSize = CGSize(width: 100, height: 100)

    var Snapshot: some View {
//        Stamp(
//            text: text,
//            color: color,
//            fontSize: fontSize,
//            angle: angle)
        let margin      = fontSize * 0.4
        let borderWidth = fontSize * 0.4
        let stampPadding = StampPadding(size, angle: angle)
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
            .background(Color.green.opacity(0.2))
            .stampCaptureSize(in: $size)
            .rotationEffect(angle)
            .padding(.leading,  stampPadding.horizontal)
            .padding(.trailing, stampPadding.horizontal)
            .padding(.top,      stampPadding.vertical)
            .padding(.bottom,   stampPadding.vertical)
            .background(Color.green.opacity(0.2))
    }

    var body: some View {
        VStack {
            if false {//snapshotViewModel.snapshotTaken {
                VStack{
                    Text("snapshot taken!")
                    Image(uiImage: snapshotViewModel.snapshot!)
                        .resizable()
                        .scaledToFit()
                }
            } else {
                VStack{
                    Text("working...")
                    Snapshot
                }
            }
        }
        .onAppear() {
            DispatchQueue.main.async {
                snapshotViewModel.snap(image: Snapshot.snapshot())
                if let s = snapshotViewModel.snapshot {
                    UIImageWriteToSavedPhotosAlbum(s, nil, nil, nil)
                }
            }
        }
    }
    
}

struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        SnapshotView(
            text: "Éjsdf928345792378983475934",
            color: C.color.bullshitRed,
            fontSize: 30,
            angle: Angle(degrees: -25.0))
    }
}

extension View {
    func snapshot() -> UIImage {
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
