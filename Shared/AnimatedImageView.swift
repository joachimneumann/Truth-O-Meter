//
//  AnimatedImageView.swift
//  Truth-O-Meter
//
//  Created by Joachim Neumann on 05/04/2021.
//

import SwiftUI

struct AnimatedImageView: UIViewRepresentable {
    var filename: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let jeremyGif = UIImage.gifImageWithName("infinity")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
        
}
