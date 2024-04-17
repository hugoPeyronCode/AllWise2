//
//  ExerciceProgressBar.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 16/04/2024.
//

import SwiftUI

struct ExerciceProgressBar: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle().frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemGreen))
                    .animation(.easeOut(duration: 0.2), value: progress)
            }.cornerRadius(45.0)
        }.frame(height: 20)
    }
}


#Preview {
    ExerciceProgressBar(progress: .constant(8))
}
