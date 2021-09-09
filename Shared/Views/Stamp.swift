//
//  Stamp.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 08/09/2021.
//

import SwiftUI



struct Stamp: View {
    @ObservedObject var stampViewModel: StampViewModel
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                HorizontalStampText(stampViewModel: stampViewModel)
                    .frame(width: stampViewModel.frameSize.width, height: stampViewModel.frameSize.height, alignment: .center)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
        }
        .stampCaptureSize(in: $stampViewModel.frameSize)
        .background(Color.black.opacity(0.1))
    }

    struct HorizontalStampText: View {
        @ObservedObject var stampViewModel: StampViewModel
        var body: some View {
                Text(stampViewModel.top)
                    .foregroundColor(Color.yellow)//stampViewModel.color)
                    .background(Color.blue.opacity(0.3))
                    .font(.system(size: 300))  // Bigger font size then final rendering
                    .fixedSize() // Prevents text truncating
                    .stampCaptureSize(in: $stampViewModel.textSize)
                    .scaleEffect(stampViewModel.scale)
        }
    }
}

struct Stamp_Previews: PreviewProvider {
    static var previews: some View {
        let stampViewModel = StampViewModel(top: "Éj23123", bottom: "bottom", color: Color.blue)
        Stamp(stampViewModel: stampViewModel)
            .background(Color.yellow.opacity(0.2))
            .padding(30)
//            .aspectRatio(1.0, contentMode: .fit)
    }
}

