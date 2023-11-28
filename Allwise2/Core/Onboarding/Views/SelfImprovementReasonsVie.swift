//
//  WhyView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

struct SelfImprovementReasonsView: View {
    
    let reasons : [(String, String)] = [
        ("Just for fun" , "🎉"),
        ("Boost my career" , "🚀"),
        ("Connect with people" , "🤝"),
        ("Spend time productively" , "⏳"),
        ("Keep my brain sharp" , "🧠"),
        ("Support my education", "📚"),
        ("Other", "♾️")
    ]

    @State var selectedReasons: [String] = []
    
    var action: () -> Void

    
    var body: some View {
        VStack {
            Text("Why do you want to improve your General Knowledge?")
                .pageTitleStyle()
            
            Spacer()
            
            ForEach(Array(reasons.enumerated()), id: \.offset) { index, reason in
                MultiSelectionButton(content: reason.0, icon: "", emoji: reason.1, variableValue: 1, isSelected: selectedReasons.contains(reason.0)) {
                    if let selectedIndex = selectedReasons.firstIndex(of: reason.0) {
                        selectedReasons.remove(at: selectedIndex)
                    } else {
                        selectedReasons.append(reason.0)
                    }
                }
            }
            
            Spacer()
            
            ValidationButton(questionState: State(), isCheckingForLifesCount: false) {
                action()
            }
        }
    }
    
    func State() -> QuestionState {
       return !selectedReasons.isEmpty ? .isValid : .isNeutral
    }
}
#Preview {
    SelfImprovementReasonsView(){}
}
