//
//  TrueButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 11/11/20.
//

import SwiftUI

struct TrueButton: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Is that true?")
                .font(.system(size: 24, design: .monospaced))
                .fontWeight(.bold)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(10)
        .background(C.Colors.bullshitRed)
        .cornerRadius(15)
        .onTapWithLocation(taphandler)
    }
    
    func taphandler(p: CGPoint, r: CGRect) {
        print(p.x / r.size.width)
    }
}



struct TrueButton_Previews: PreviewProvider {
    static var previews: some View {
        TrueButton()
    }
}

public extension View {
  func onTapWithLocation(coordinateSpace: CoordinateSpace = .local, _ tapHandler: @escaping (CGPoint, CGRect) -> Void) -> some View {
    modifier(TapLocationViewModifier(tapHandler: tapHandler, coordinateSpace: coordinateSpace))
  }
}

fileprivate struct TapLocationViewModifier: ViewModifier {
  let tapHandler: (CGPoint, CGRect) -> Void
  let coordinateSpace: CoordinateSpace

  func body(content: Content) -> some View {
    content.overlay(
      TapLocationBackground(tapHandler: tapHandler, coordinateSpace: coordinateSpace)
    )
  }
}

fileprivate struct TapLocationBackground: UIViewRepresentable {
  var tapHandler: (CGPoint, CGRect) -> Void
  let coordinateSpace: CoordinateSpace

  func makeUIView(context: UIViewRepresentableContext<TapLocationBackground>) -> UIView {
    let v = UIView(frame: .zero)
    let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped))
    v.addGestureRecognizer(gesture)
    return v
  }

  class Coordinator: NSObject {
    var tapHandler: (CGPoint, CGRect) -> Void
    let coordinateSpace: CoordinateSpace

    init(handler: @escaping ((CGPoint, CGRect) -> Void), coordinateSpace: CoordinateSpace) {
      self.tapHandler = handler
      self.coordinateSpace = coordinateSpace
    }

    @objc func tapped(gesture: UITapGestureRecognizer) {
      let point = coordinateSpace == .local
        ? gesture.location(in: gesture.view)
        : gesture.location(in: nil)
        tapHandler(point, gesture.view!.bounds)
    }
  }

  func makeCoordinator() -> TapLocationBackground.Coordinator {
    Coordinator(handler: tapHandler, coordinateSpace: coordinateSpace)
  }

  func updateUIView(_: UIView, context _: UIViewRepresentableContext<TapLocationBackground>) {
    /* nothing */
  }
}
