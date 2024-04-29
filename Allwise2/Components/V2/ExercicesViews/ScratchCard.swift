//
//  ScratchCard.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 16/04/2024.
//

import SwiftUI

struct ScratchCard: View {
    var affirmation: String
    var index: Int
    @Binding var revealedAffirmations: Set<Int>
    @Binding var progress: Double
    var total: CGFloat
    
    @State private var currentLine = Line()
    @State private var lines = [Line]()
    @State private var showStars = false
    @State private var fadeInOut = false

    var body: some View {
        ZStack(alignment: .top) {
            // Hidden content view (affirmation)
            FluidGradientView()
            
            // Scratchable overlay view
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.8))
                .frame(maxWidth: .infinity, maxHeight: 70)
                .overlay(
                    Text(affirmation)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 65)
                )
                .mask(
                    Canvas { context, _ in
                        for line in lines {
                            var path = Path()
                            path.addLines(line.points)
                            context.stroke(path,
                                           with: .color(.white),
                                           style: StrokeStyle(lineWidth: line.lineWidth,
                                                              lineCap: .round,
                                                              lineJoin: .round)
                            )
                        }
                    }
                )
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged({ value in
                            let newPoint = value.location
                            currentLine.points.append(newPoint)
                            lines.append(currentLine)
                        })
                        .onEnded({ _ in
                            lines.append(currentLine)
                            // Check the total number of points across all lines
                            if getTotalPoints() > 500 {
                                if revealedAffirmations.insert(index).inserted {
                                    // Only increment progress if this is the first time the card is revealed
                                    
                                    //TO IMPROVE / DISPLAY TOO MANY TIMES
                                    progress += 1.0 / Double(total)
                                    showStars = true
                                    startPlayingSound(soundname: "satisfactory_sound_1")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        showStars = false
                                        stopPlayingMusic()
                                    }


                                }
                            }
                            currentLine = Line() // Start a new line for the next gesture
                        })
                )
            
            if showStars {
                HStack {
                    VStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.darkGreen)
                            .frame(width: 50, height: 30)
                            .scaleEffect(fadeInOut ? 0.5 : 2.0) // Larger when fadeInOut is true
                        Image(systemName: "star.fill")
                            .foregroundColor(.darkGreen)
                            .frame(width: 50, height: 20)
                            .scaleEffect(fadeInOut ? 0.8 : 1.5) // Smaller when fadeInOut is true
                    }
                    .padding(.leading, 5)
                    .opacity(fadeInOut ? 1 : 0) // Fade effect

                    Spacer()

                    VStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.darkGreen)
                            .frame(width: 50, height: 30)
                            .scaleEffect(fadeInOut ? 0.5 : 2.0) // Larger when fadeInOut is true
                        Image(systemName: "star.fill")
                            .foregroundColor(.darkGreen)
                            .frame(width: 50, height: 20)
                            .scaleEffect(fadeInOut ? 0.5 : 2.0) // Larger when fadeInOut is true
                    }
                    .padding(.trailing, 5)
                    .opacity(fadeInOut ? 1 : 0) // Fade effect
                }
                .onAppear {
                    playHaptic(intensity: 0.4, sharpness: 0.4)
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        fadeInOut.toggle()
                    }
                }
            }
        }.onAppear {
            prepareHaptics()
        }
    }
    
    // Calculate the total number of points in all lines
    private func getTotalPoints() -> Int {
        return lines.reduce(0) { $0 + $1.points.count }
    }
    
    private var isRevealed: Binding<Bool> {
        Binding<Bool>(
            get: { self.revealedAffirmations.contains(self.index) },
            set: { isRevealed in
                if isRevealed {
                    self.revealedAffirmations.insert(self.index)
                } else {
                    self.revealedAffirmations.remove(self.index)
                }
            }
        )
    }
}

#Preview {
    ScratchCard(
        affirmation: "You are doing great!",
        index: 0,
        revealedAffirmations: .constant(Set<Int>()),
        progress: .constant(0.2),
        total: 5
    )
}


