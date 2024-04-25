//
//  MeditationCanvasView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct MeditationCanvasView<S: Shape>: View {
    let shape: S
    let innerCircleScaleEffect: CGFloat
    let rotationAngle: Double
    let gradient: RadialGradient
    
    var body: some View {
        
        ZStack {
            shape
                .fill(.gray.opacity(0.1))
            
            ForEach(0 ..< 7) { item in
                shape
                    .stroke(lineWidth: 10)
                    .fill(.white.opacity(0.7))
                    .scaleEffect(CGFloat(item) * 0.15)
            }
            
            shape
                .fill(.ultraThinMaterial)
                .scaleEffect(innerCircleScaleEffect)
        }
        .rotationEffect(.degrees(rotationAngle))
        .frame(width: SizeConstants.screenWidth * 0.80, height: SizeConstants.screenWidth * 0.80)
    }
}

#Preview {
    ZStack {
        ReusableVideoPlayer(fileName: .constant("rain1"), fileType: "mp4")
            .scaledToFill()
            .ignoresSafeArea()
        MeditationCanvasView(shape: RoundedRectangle(cornerRadius: 15), innerCircleScaleEffect: 0, rotationAngle: 360, gradient: ColorGradients.radialGradient3)
    }
}


// Cool Shapes and settings
// 
