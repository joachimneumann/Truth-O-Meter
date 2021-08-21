//
//  RecordButton.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 14/11/2020.
//


import SwiftUI
import Combine

let ringWidth:CGFloat = 0.05
let innerRadius:CGFloat = 0.88
let innerRect:CGFloat = 0.4

struct WaitView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Circle()
                    .fill(C.Colors.bullshitRed)
                    .frame(width: r*innerRadius, height: r*innerRadius)
                    .onTapGesture {
                        viewModel.setState(.listen)
                    }
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value: 1.0)
            }
        }
    }
}

struct ListenView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                Rectangle()
                    .foregroundColor(C.Colors.bullshitRed)
                    .frame(width: r*innerRect, height: r*innerRect)
                    .cornerRadius(10)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.bullshitRed, value:  viewModel.listeningProgress)
            }
        }
    }
}

struct AnalyseView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            ZStack{
                ThinkingGif(viewModel: viewModel)
                    .background(Color.green)
                    .frame(width: r, height: r/2, alignment: .center)
                HorizontalProgressBar(color: C.Colors.bullshitRed, value:  viewModel.analyseProgress)
                    .frame(width: r, height: 6, alignment: .center)
                    .padding(.top, r/2+20)
            }
        }
    }
}

struct ShowView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        GeometryReader { (geometry) in
            let r:CGFloat = min(geometry.size.width, geometry.size.height)
            VStack {
                if let stampImage = viewModel.stamp {
                    Image(cpImage: stampImage)
                        .resizable()
                        .frame(width: r, height: r)
                } else {
                    Text("missing stamp")
                        .frame(width: r, height: r, alignment: .center)
                }
            }
        }
    }
}


struct ControlView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        HStack {
            switch(viewModel.state) {
            case .wait:
                WaitView(viewModel: viewModel)
            case .listen:
                ListenView(viewModel: viewModel)
            case .analyse:
                AnalyseView(viewModel: viewModel)
            case .show:
                ShowView(viewModel: viewModel)
            }
        }
        .padding(60)
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        viewModel.setState(.show)
        return VStack {
            Spacer()
            ModelDebugView(viewModel: viewModel)
            Spacer()
            ControlView(viewModel: viewModel)
                .aspectRatio(1.0, contentMode: .fit)
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}
