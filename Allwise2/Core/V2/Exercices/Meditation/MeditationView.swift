//
//  MeditationView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct MeditationView: View {
    @ObservedObject var progressBarViewModel: ProgressBarViewModel
    
    @State private var innerCircleScaleEffect : CGFloat = 0.1
    @State private var rotationAngle: Double = 0
    @State private var topText = ""
    
    // Might use that later but now Generics does not allow to dynamically change the shapes in the view.
//    let shapes : [any Shape] = [RoundedRectangle(cornerRadius: 150), Circle()]
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ReusableVideoPlayer(fileName: "rain2", fileType: "mp4")
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HeaderGradient()
                
                VStack {
                    Header
                    
                    CustomProgressBar(progress: 0.5, color: .blue)
                        .shadow(color: .gray, radius: 3)
                        .frame(width: SizeConstants.screenWidth / 2)
                        .padding(.top)
                    
                    Spacer()
                    
                    MeditationCanvasView(shape: Circle(), innerCircleScaleEffect: innerCircleScaleEffect, rotationAngle: rotationAngle)
                        .onTapGesture {
                            growingInnerCircle()
                        }
                        .onAppear{
                            startRotating()
                        }
                    
                    Spacer()
                    
                    MainProgressBar(viewModel: progressBarViewModel)
                        .frame(height: SizeConstants.screenHeight * 0.1)
                    
                    .padding(.horizontal)
                    
                }
            }
        }
    }
}


extension MeditationView {
    
    var Header : some View {
        VStack(alignment: .center, spacing: 10) {
            ExerciceSubtitle(emoji: "🧘", subtitle: "MEDITATION", subtitleColor: .green)
            Consigne(text: "Take a moment to recharge")
        }
        .padding()
    }
    
    var MeditationCanvas : some View {
        ZStack {
            Circle()
                .fill(ColorGradients.premiumGradient)
                .rotationEffect(.degrees(rotationAngle))
            ForEach(0 ..< 5) { item in
                Circle()
                    .stroke(lineWidth: 15)
                    .fill(.ultraThinMaterial)
                    .scaleEffect(CGFloat(item) * 0.25)
            }
            Circle()
                .fill(.thinMaterial)
                .scaleEffect(innerCircleScaleEffect)
        }
        .frame(width: SizeConstants.screenWidth * 0.90)
    }
}

extension MeditationView {
    func growingInnerCircle() {
        withAnimation(.snappy(duration: 15)) { // Smooth transition over 2 seconds
            if innerCircleScaleEffect >= 1 {
                innerCircleScaleEffect = 0.1 // reset to initial small size
            } else {
                innerCircleScaleEffect = 1.1 // grow to full size
            }
        }
    }
    
    func startRotating() {
        withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)){
            rotationAngle = 360
        }
    }

}

#Preview {
    MeditationView(progressBarViewModel: ProgressBarViewModel())
}
