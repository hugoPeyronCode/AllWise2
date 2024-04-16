//
//  ExerciceProgressBar_2.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 17/04/2024.
//

import SwiftUI

struct ExerciceProgressBar_2: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle().frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemGreen))
                    .animation(.easeOut(duration: 0.5), value: progress)
            }
            .cornerRadius(45.0)
        }
        .frame(height: 20)
    }
}

#Preview {
    ExerciceProgressBar_2(progress: .constant(2))
}
