//
//  MaskView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 05/09/2021.
//

import SwiftUI

struct MaskView: View {
    var body: some View {
        Image(cpImage: CPImage(named: "mask")!)
            .resizable()
            .scaledToFill()
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
    }
}
