//
//  SnapshotView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/09/2021.
//

import SwiftUI

//struct FitToWidth: ViewModifier {
//    var fraction: CGFloat = 1.0
//    func body(content: Content) -> some View {
//        GeometryReader { g in
//            content
//                .font(.system(size: 1000))
//                .minimumScaleFactor(0.005)
//                .lineLimit(1)
//                .frame(width: g.size.width*self.fraction, height: g.size.height)
//        }
//    }
//}

var counter = 0

struct SnapshotView: View {
    var fraction: CGFloat = 1.0
    var text: String
    var color: Color
    let fontSize:CGFloat
    var angle: Angle
    @StateObject var snapshotViewModel = SnapshotViewModel(angle: Angle(degrees: -25.0))

    @State var size: CGSize = CGSize(width: 100, height: 100)
    
    var Snapshot: some View {
        //        Stamp(
        //            text: text,
        //            color: color,
        //            fontSize: fontSize,
        //            angle: angle)
        //            .background(Color.red.opacity(0.2))
        //            .modifier(FitToWidth(fraction: fraction))
        let margin      = fontSize * 0.4
        let borderWidth = fontSize * 0.4
        let stampPadding = StampPadding(size, angle: angle)
        let _ = print("...\(counter)")
        let _ = counter = counter + 1
        return Text(String(counter)+text)
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
        //            .background(Color.red.opacity(0.2))
        //            .stampCaptureSize(in: $size)
        //            .rotationEffect(angle)
        //            .padding(.horizontal,  stampPadding.horizontal)
        //            .padding(.vertical,  stampPadding.vertical)
        //            .background(Color.green.opacity(0.2))
    }
    
    var body: some View {
        VStack {
            if snapshotViewModel.snapshotTaken {
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
        .background(Color.green.opacity(0.2))
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                //            DispatchQueue.main.async {
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
            text: "Éjsdf92834dfgdgdlfgfdgdfgdgfdfg",
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
