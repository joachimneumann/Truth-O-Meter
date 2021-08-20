//
//  ContentView.swift
//  Shared
//
//  Created by Joachim Neumann on 11/10/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        
        #if os(macOS)
        let w : CGFloat = 375
        let h : CGFloat = 667
        ExtractedView(viewModel: viewModel)
            .frame(minWidth: w, minHeight: h)
            .frame(maxWidth: w, maxHeight: h)
            .background(Color.white)
        #endif

        #if os(iOS)
        ExtractedView(viewModel: viewModel)
        #endif
        
    }
}


struct SettingsIcon: View {
    var body: some View {
        Image("settings")
            .resizable()
            .scaledToFit()
            .frame(width: 30.0, height: 30.0)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        ContentView(viewModel: viewModel)
    }
}

struct ExtractedView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Display(viewModel: viewModel)
                .padding(20)
            Spacer()
            ControlView(viewModel: viewModel)
                .padding(20)
            Spacer()
            Spacer()
            HStack {
                Spacer()
                SettingsIcon()
            }
            .background(Color.yellow)
        }
    }
}
