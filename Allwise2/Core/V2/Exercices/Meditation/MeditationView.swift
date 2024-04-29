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
    
    @State private var exerciceTime : Int = 30
    
    @State var videos : [String] = ["city1", "city2", "cloud1", "rain1", "rain2", "rain3", "rain4", "sea1", "sea2", "sea3", "sea4", "sea5", "sea6" ]
    
    @State private var counter = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ReusableVideoPlayer(fileName: $videos[counter], fileType: "mp4")
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                
                HeaderGradient()
                
                VStack {
                    Header
                    
                    CustomProgressBar(progress: 0.5, color: .blue)
                        .frame(width: SizeConstants.screenWidth / 2)
                        .padding(.top)
                    
                    HStack {
                        Button {
                            if counter > 0 {
                                counter -= 1
                            }
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Button {
                            if counter < videos.count - 1 {
                                counter += 1
                            }
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding()
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(.white)

                    
                    Spacer()
                    
                    // Cool shape to try:
//                    RoundedRectangle(cornerRadius: 150)
                    MeditationCanvasView(shape: RoundedRectangle(cornerRadius: 150), innerCircleScaleEffect: innerCircleScaleEffect, rotationAngle: rotationAngle, gradient: ColorGradients.radialGradient3)
                        .onTapGesture {
                            growingInnerCircle()
                        }
                        .onAppear{
                            startRotating()
                        }
                    
                    Spacer()
                    
                   SessionProgressBar(viewModel: progressBarViewModel)
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
        withAnimation(.linear(duration: 15)) { // Smooth transition over 2 seconds
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
