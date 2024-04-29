//
//  FluidGradientView.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 30/04/2024.
//

import SwiftUI
import Combine

struct FluidGradientView: View {
    // Enhanced gradient colors for a richer appearance
    @State private var colors = [
        Color(red: 0.67, green: 0.88, blue: 0.69),  // Light greenish tint
        Color(red: 0.12, green: 0.73, blue: 0.58),  // Mid-tone green
        Color(red: 0.09, green: 0.55, blue: 0.42)   // Deep green
    ]
    
    @State private var startPoint = UnitPoint.center
    @State private var endPoint = UnitPoint.center
    
    // Timer and animation parameters
    @State private var time: Double = 0
    @State private var timer: AnyCancellable?

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: startPoint,
                               endPoint: endPoint)
            )
            .frame(maxWidth: .infinity, maxHeight: 70)
            .blur(radius: 0.1) // Apply blur effect to the gradient
            .onAppear {
                timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect().sink { _ in
                    updateGradientPoints(time: time)
                    time += 0.1
                    
                    // Gradually shift colors
                    if time.truncatingRemainder(dividingBy: 3) == 0 { // Every 3 seconds
                        withAnimation(.linear(duration: 3)) {
                            colors.shuffle()
                        }
                    }
                }
            }
            .onDisappear {
                timer?.cancel()
            }
    }
    
    // Function to update gradient based on a time parameter
    private func updateGradientPoints(time: Double) {
        withAnimation(.easeInOut(duration: 0.1)) {
            let normalizedTime = time / 10 // Normalize the time to reduce speed
            // Sine and Cosine functions to create looping, yet non-repeating patterns
            startPoint = UnitPoint(x: 0.5 + 0.5 * sin(normalizedTime), y: 0.5 + 0.5 * cos(normalizedTime))
            endPoint = UnitPoint(x: 0.5 - 0.5 * sin(normalizedTime), y: 0.5 - 0.5 * cos(normalizedTime))
        }
    }
}


#Preview {
    FluidGradientView()
}
