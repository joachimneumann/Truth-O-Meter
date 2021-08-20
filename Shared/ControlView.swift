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
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value:  1.0)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.bullshitRed, value:  viewModel.ringProgress)
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
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.lightGray, value:  1.0)
                CircularProgressBar(ringWidth: r*ringWidth, color: C.Colors.bullshitRed, value:  viewModel.ringProgress)
            }
        }
    }
}

struct ShowView: View {
    var body: some View {
        Text("Bullshit")
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
                ShowView()
            }
        }
        .padding()
    }
}


struct RecordButton_Previews : PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        VStack {
            Spacer()
            ModelDebugView(viewModel: viewModel)
            Spacer()
            ZStack {
                Rectangle()
                ControlView(viewModel: viewModel)
            }
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Spacer()
        }
    }
}
