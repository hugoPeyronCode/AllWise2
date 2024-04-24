//
//  ExerciceSubtitle.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 16/04/2024.
//

import SwiftUI

struct ExerciceSubtitle: View {
    var emoji: String
    var subtitle: String
    var subtitleColor: Color

    var body: some View {
        HStack {
            Text(emoji)
                .font(.largeTitle)
            Text(subtitle)
                .foregroundColor(subtitleColor)
                .font(.headline)
                .fontWeight(.bold)
                .fontDesign(.monospaced)
        }
    }
}

struct ExerciceSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        ExerciceSubtitle(emoji: "🌟", subtitle: "Keep Going!", subtitleColor: .blue)
            .previewLayout(.sizeThatFits)
    }
}
