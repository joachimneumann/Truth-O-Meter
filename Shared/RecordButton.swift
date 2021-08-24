//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//

import SwiftUI

struct WaitRecordButton: View {
    var body: some View {
        return GeometryReader { (geometry) in
            let radius:CGFloat = min(geometry.size.width, geometry.size.height)
            let ringWidth = radius * 0.05
            Circle()
                .trim(from: 0, to: 1)
                .stroke(C.Colors.lightGray, lineWidth:ringWidth)
            Circle()
                .fill(C.Colors.bullshitRed)
                .padding(radius*0.07)
        }
    }
}

struct ListenRecordButton: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        return GeometryReader { (geometry) in
            let radius:CGFloat = min(geometry.size.width, geometry.size.height)
            let ringWidth = radius * 0.05
            Circle()
                .trim(from: 0, to: 1)
                .stroke(C.Colors.lightGray, lineWidth:ringWidth)
            Circle()
                .trim(from: 0, to: 0.7)//viewModel.listeningProgress)
                .stroke(C.Colors.bullshitRed, lineWidth:ringWidth)
                .rotationEffect(Angle(degrees:-90))
            Rectangle()
                .foregroundColor(C.Colors.bullshitRed)
                .cornerRadius(radius*0.1)
                .padding(radius/4)
        }
    }
}

struct SettingsRecordButton: View {
    var body: some View {
        return GeometryReader { (geometry) in
            let radius:CGFloat = min(geometry.size.width, geometry.size.height)
            let ringWidth = radius * 0.05
            Circle()
                .trim(from: 0, to: 1)
                .stroke(C.Colors.paleLightGray, lineWidth:ringWidth)
            Circle()
                .fill(C.Colors.paleBullshitRed)
                .padding(radius*0.07)
        }
    }
}


struct RecordButton: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack {
            switch(viewModel.state) {
            case .wait:
                WaitRecordButton()
            case .listen:
                ListenRecordButton(viewModel: viewModel)
            case .analyse:
                Text("analyse")
            case .show:
                Text("show")
            case .settings:
                SettingsRecordButton()
            }
        }
        .aspectRatio(contentMode: .fit)
//        .background(Color.yellow)
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setStateWithoutTimer(.listen)
        return VStack {
            ModelDebugView(viewModel: viewModel)
            RecordButton(viewModel: viewModel)
                .padding(30)
            Spacer()
        }
    }
}
