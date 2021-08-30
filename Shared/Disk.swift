//
//  Disk.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 30/08/2021.
//

import SwiftUI

struct Disk: View {
    var precision: Precision
    var down: (_: Precision) -> Void
    var up: (_: Precision) -> Void
    var isSetting: Bool
    var isGray: Bool

    @State private var isVisible = true
    var body: some View {
        ZStack {
            Circle()
                .fill(isGray ? C.color.lightGray : C.color.bullshitRed)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            print("Disk down")
                            down(precision)
                        }

                        .onEnded { _ in
                            print("Disk up")
                            up(precision)
                        }
                )
            if isSetting{
                Circle()
                    .stroke(C.color.lightGray, lineWidth: 1)
            }
        }
        .opacity(isVisible ? 1.0 : 0.0)
    }
}

struct Disk_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ViewModel()
        let diskViewModel = DiskViewModel(
            callback: viewModel.tap,
            isSetting: viewModel.isSettingsState)
        Disk(precision: .middle, down: diskViewModel.down, up: diskViewModel.up, isSetting: true,
             isGray: false)
    }
}
