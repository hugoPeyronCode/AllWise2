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
    
    var body: some View {
        ZStack {
            // Hidden content view (affirmation)
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .frame(maxWidth: .infinity, maxHeight: 70)
            
            // Scratchable overlay view
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.3))
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
                                    progress += 1.0 / Double(total)
                                }
                            }
                            currentLine = Line() // Start a new line for the next gesture
                        })
                )
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
