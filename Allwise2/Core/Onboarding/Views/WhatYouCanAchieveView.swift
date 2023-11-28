//
//  WhatYouCanAchieveView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

struct WhatYouCanAchieveView: View {
    
    let options: [(String, String)] = [
        ("Develop a Learning Habit", "⏱️"),
        ("Expand World Awareness", "🌍"),
        ("Enhance Conversational Skills", "💬"),
        ("Boost Cognitive Abilities", "🧠")
    ]
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text("Here's is what you can achieve!")
                .pageTitleStyle()
            
            Spacer()
            
            ForEach(Array(options.enumerated()), id: \.offset)  { index, option in
                MultiSelectionButton(content: option.0 , icon: "", emoji: option.1, variableValue: 0, isSelected: false, action: {})
            }
            
            Spacer()
            
            ValidationButton(questionState: .isValid, isCheckingForLifesCount: false) {
                action()
            }
            
        }
    }
}

#Preview {
    WhatYouCanAchieveView(){}
}
