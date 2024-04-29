//
//  MeditationView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct MeditationView: View {
    @ObservedObject var viewModel: MeditationViewModel
    @ObservedObject var progressBarViewModel: SessionProgressBarViewModel
    
    @State private var innerCircleScaleEffect: CGFloat = 0.1
    @State private var rotationAngle: Double = 0
    @State var videos: [String] = ["city1", "city2", "cloud1", "rain1", "rain2", "rain3", "rain4", "sea1", "sea2", "sea3", "sea4", "sea5", "sea6"]
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
                
                Header

                MeditationCanvasView(shape: Circle(), innerCircleScaleEffect: innerCircleScaleEffect, rotationAngle: rotationAngle, gradient: ColorGradients.radialGradient2)
                    .onTapGesture {
                        growingInnerCircle()
                    }
                
                SessionProgressBarPlacement

            }
            .onAppear {
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
        }
    }
}

extension MeditationView {
    
    var Header : some View {
        VStack(alignment: .center, spacing: 10) {
            ExerciceSubtitle(emoji: "🧘", subtitle: "MEDITATION", subtitleColor: .green)
            Consigne(text: "Take a moment to focus")
            CustomProgressBar(progress: viewModel.progress, color: .white.opacity(0.8))
                .frame(width: SizeConstants.screenWidth / 2)
                .padding(.top)
            
            Spacer()
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
    
    
    var LeftRightArrows : some View {
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
    }
    
    var SessionProgressBarPlacement : some View {
        VStack {
            Spacer()
            SessionProgressBar(viewModel: progressBarViewModel)
                .frame(height: SizeConstants.screenHeight * 0.1)
                .padding(.horizontal)
        }
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
    MeditationView(viewModel: MeditationViewModel(), progressBarViewModel: SessionProgressBarViewModel())
}
