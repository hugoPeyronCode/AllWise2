//
//  CircularProgressBar.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let color : Color
    let fontSize: Font
    let lineWidth : CGFloat
    let withText : Bool
    
    init(progress: Double, color: Color) {
        self.progress = progress
        self.color = color
        self.fontSize = .largeTitle
        self.lineWidth = 10
        self.withText = true
    }
    
    init(progress: Double, color: Color, fontSize : Font, lineWidth:  CGFloat, withText: Bool) {
        self.progress = progress
        self.color = color
        self.fontSize = fontSize
        self.lineWidth = lineWidth
        self.withText = withText
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    .gray.opacity(0.5),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
            
            if withText {
                Text("\(progress * 100, specifier: "%.0f")%")
                    .font(fontSize)
                    .fontWeight(.black)
            }
        }
    }
}

struct CircularProgressBarTestView: View {
    // 1
    @State var progress: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                // 2
                CircularProgressView(progress: progress, color: .mint)
                // 3
            }.frame(width: 150, height: 150)
            Spacer()
            HStack {
                // 4
                Slider(value: $progress, in: 0...1)
                // 5
                Button("Reset") {
                    resetProgress()
                }.buttonStyle(.borderedProminent)
            }
        }
    }
    
    func resetProgress() {
        progress = 0
    }
}

#Preview {
    CircularProgressBarTestView()
}

