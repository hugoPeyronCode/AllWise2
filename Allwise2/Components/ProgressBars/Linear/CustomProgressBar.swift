//
//  CustomProgressBar.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct CustomProgressBar: View {
    // The progress variable should be between 0 and 1
    var progress: Float
    let color: Color
    
    init(progress: Float, color: Color) {
        self.progress = progress
        self.color = color
    }
    
    init(progress: Float) {
        self.progress = progress
        self.color = .green
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    .foregroundStyle(.reverseWhite.opacity(0.4))

                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    .frame(width: geometry.size.width * CGFloat(progress))
                    .foregroundColor(color) // Foreground indicating progress
                    .animation(.linear, value: progress)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 10)
    }
}

#Preview {
    CustomProgressBar(progress: 0.5)
}
