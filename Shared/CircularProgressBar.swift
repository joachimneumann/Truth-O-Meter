//
//  CircularProgressBar.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI

struct RecordButton: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        var value:CGFloat = 0.0
        if viewModel.state == .listen {
            value = viewModel.listeningProgress
        }
        return GeometryReader { (geometry) in
            let radius:CGFloat = min(geometry.size.width, geometry.size.height)
            let ringWidth = radius * 0.05
            ZStack {
                if viewModel.state == .wait {
                    Circle()
                        .fill(C.Colors.bullshitRed)
                        .padding()
                }
                if viewModel.state == .listen {
                    Rectangle()
                        .foregroundColor(C.Colors.bullshitRed)
                        .cornerRadius(radius*0.1)
                        .aspectRatio(contentMode: .fit)
                        .padding(radius*0.25)
                }
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(C.Colors.lightGray, lineWidth:ringWidth)
                Circle()
                    .trim(from: 0, to: value)
                    .stroke(C.Colors.bullshitRed, lineWidth:ringWidth)
                    .rotationEffect(Angle(degrees:-90))
            }
        }
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setState(.listen)
        return RecordButton(viewModel: viewModel)
            .padding()
    }
}
