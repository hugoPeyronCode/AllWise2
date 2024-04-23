//
//  LazyFitnessExercice.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 17/04/2024.
//

import SwiftUI

struct LazyFitnessExercice: View {
    @State private var seated: Bool? = nil
    @State private var selectedImageName: String = ""
    @State private var showFinishButton = false
    @State private var progress: Double = 0.0
    
    private let seatImages = ["seat_0", "seat_1"]
    private let handImages = ["hand_0", "hand_1", "hand_2", "hand_3", "hand_4"]
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            ColorGradients.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Are you seated?")
                    .font(.title)
                    .padding()
                
                HStack {
                    Button("Yes") {
                        seated = true
                        selectedImageName = seatImages.randomElement() ?? ""
                        startImageDisplayTimer()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("No") {
                        seated = false
                        selectedImageName = handImages.randomElement() ?? ""
                        startImageDisplayTimer()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                
                if !selectedImageName.isEmpty {
                    Image(selectedImageName) // Ensure these images are in your assets folder
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .transition(.opacity)
                }
                
                if showFinishButton {
                    Button("Finish") {
                        // Actions to perform on finish
                        print("Exercise finished")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
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
    
    func startImageDisplayTimer() {
        progress = 0.0 // Reset the progress to 0 at the start
        showFinishButton = false // Hide the finish button until the end
        
        // Timer that fires every 0.2 seconds to update progress smoothly over 20 seconds
        let interval = 0.2
        let totalDuration = 20.0 // Total duration to fill the bar
        let increment = interval / totalDuration // Increment to add to progress each timer fire

        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            withAnimation(.linear(duration: interval)) {
                progress += increment
            }
            
            if progress >= 1.0 { // Check if the progress is complete
                timer.invalidate() // Stop the timer
                progress = 1.0 // Ensure progress is set to exactly 1.0
                showFinishButton = true // Show the finish button
            }
        }
    }
    var XMark: some View {
        Button {
            withAnimation(.snappy){
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
    LazyFitnessExercice()
}
