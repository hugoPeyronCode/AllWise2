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
    
    var body: some View {
        
        let gradient = RadialGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]),
            center: .center,
            startRadius: 0,
            endRadius: SizeConstants.screenWidth * 0.45
        )
        
        ZStack {
            shape
                .fill(gradient)
            
            ForEach(0 ..< 5) { item in
                shape
                    .stroke(lineWidth: 15)
                    .fill(.ultraThinMaterial)
                    .scaleEffect(CGFloat(item) * 0.25)
            }
            
            shape
                .fill(.thinMaterial)
                .scaleEffect(innerCircleScaleEffect)
        }
        .rotationEffect(.degrees(rotationAngle))
        .frame(width: SizeConstants.screenWidth * 0.90, height: SizeConstants.screenWidth * 0.90)
    }
}

#Preview {
    MeditationCanvasView(shape: RoundedRectangle(cornerRadius: 15), innerCircleScaleEffect: 1, rotationAngle: 360)
}
