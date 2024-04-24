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


    
    var body: some View {
        NavigationStack {
            ZStack {
//                ColorGradients.white
//                    .ignoresSafeArea()
                
                VStack {
                    Header
                    
                    Spacer()
                    
                    Text("\(topText)")
                        .padding(.bottom)
                    
                    MeditationCanvasView(shape: RoundedRectangle(cornerRadius: 150), innerCircleScaleEffect: innerCircleScaleEffect, rotationAngle: rotationAngle)
                        .onTapGesture {
                            growingInnerCircle()
                        }
                        .onAppear{
                            startRotating()
                        }
                    
                    Spacer()
                    
                    MainProgressBar(viewModel: progressBarViewModel, isShowingReset: false)
                        .frame(height: SizeConstants.screenHeight * 0.1)
                    
//                    ContinueButton(content: "Continue", backgroundColor: .gray, shadowGroundColor: .gray.dark) {
//                        progressBarViewModel.incrementProgress()
//                    }
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
            
//            Text("FOCUS...")
//                .fontWeight(.black)
//                .fontDesign(.monospaced)
//                .foregroundStyle(.white)
        }
        .frame(width: SizeConstants.screenWidth * 0.90)
    }
}

extension MeditationView {
    func growingInnerCircle() {
        withAnimation(.snappy(duration: 15)) { // Smooth transition over 2 seconds
            if innerCircleScaleEffect >= 1 {
                innerCircleScaleEffect = 0.1 // reset to initial small size
                topText = "Shrinking"
            } else {
                innerCircleScaleEffect = 1.1 // grow to full size
                topText = "Growing"
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
