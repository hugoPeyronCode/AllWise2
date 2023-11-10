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

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    .foregroundColor(Color.gray.opacity(0.2)) // Background of the progress bar

                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    .frame(width: geometry.size.width * CGFloat(progress))
                    .foregroundColor(Color.green) // Foreground indicating progress
                    .animation(.linear, value: progress)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 10)
    }
}

#Preview {
    CustomProgressBar(progress: 0.5)
}
