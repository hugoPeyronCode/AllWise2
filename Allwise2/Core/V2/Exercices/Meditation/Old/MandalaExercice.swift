//
//  MandalaExercice.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 15/04/2024.
//

import SwiftUI
import AVFoundation
import CoreHaptics
import AVKit

struct MandalaExercice: View {
    let exerciseTimer = ExerciseTimer()
    let randomNumber = Int.random(in: 0...1)
    
    @State private var progress = 0.0
    @State private var animateButton = false
    @State private var showQuitOverlay = false

    @State private var player = AVPlayer()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            
            // Here I would like to have a video looping in the background.
            
            VStack(alignment: .leading) {
                HStack {
                    ExerciceSubtitle(emoji: "🧘", subtitle: "MEDITATION", subtitleColor: .green)
                }
                
                Consigne(text: "Take a moment to recharge")
                
                GeometryReader { geometry in
                    VideoPlayer(player: player)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(Circle()
                        )
                }
                Button(action: {
                    // Continue button action
                    print("Button clicked")
                }) {
                    HStack {
                        Spacer()
                        
                        Text("TAP")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                            .padding(10)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("paleGray"))
                    .cornerRadius(10)
                    .scaleEffect(animateButton ? 1.1 : 1.0)
                     .animation(.easeInOut(duration: 0.8), value: animateButton)
                }

            }                        .padding([.leading, .trailing], 20)

        }
        .onAppear {
            self.setupAudio()
            self.setupHaptics()
            player = AVPlayer(url:  Bundle.main.url(forResource: "mandala_\(randomNumber)", withExtension: "mp4")!)
            player.play()
        }
        .onTapGesture {
            self.handleTap()
        }
        .onDisappear {
            self.stopAudio()
            player.pause()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                XMark
            }
            ToolbarItem(placement: .principal) {
                ExerciceProgressBar(progress: $progress)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
    
    private func setupAudio() {
        // Setup audio player
        startPlayingMusic()
        exerciseTimer.onProgressUpdate = { newProgress in
            self.progress = newProgress
        }
        exerciseTimer.startExercise()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.progress >= 1.0 {
                timer.invalidate()
            }
            exerciseTimer.updateProgress()
        }
        exerciseTimer.onBellRing = {
            withAnimation {
                self.animateButton = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation {
                    self.animateButton = false
                }
            }
        }
    }
    
    private func stopAudio() {
        // Setup audio player
        stopPlayingMusic()
        exerciseTimer.viewDidDisappear()
    }
    
    private func setupHaptics() {
        // Setup haptic engine
        prepareHaptics()
    }
    
    private func handleTap() {
        // Play haptic pattern
        playHaptic(intensity: 0.5, sharpness: 0.2)
    }
    
    var XMark: some View {
        Button {
            withAnimation(.snappy){
                showQuitOverlay.toggle()
                dismiss()

            }
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .bold()
                .font(.title3)
        }
    }
}

#Preview {
    MandalaExercice()
}
