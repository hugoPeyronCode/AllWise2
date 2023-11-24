//
//  GeneralKnowledgeLevelView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

struct GeneralKnowledgeLevelView: View {
    
    let options : [(String, CGFloat)] = [
        ("I need to review the basics", 0),
        ("I am somewhat informed", 0.25),
        ("I am confidently knowledgeable", 0.5),
        ("I'm nearly omniscient", 1)
    ]
    
    // State to keep track of the selected option
    @State private var selectedOptionIndex: Int? = nil

    var body: some View {
        VStack {
            
            Text("What's your knowledge level?")
                .pageTitleStyle()
            
            Spacer()
            
            // Loop through the options to create buttons
            ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                  MultiSelectionButton(content: option.0, icon: "chart.bar.fill", variableValue: option.1, isSelected: index == selectedOptionIndex) {
                      self.selectedOptionIndex = index
                  }
              }
            
            Spacer()
            
            ValidationButton(questionState: selectedOptionIndex != nil ? .isValid : .isNeutral) {
                // move to the next page
            }
        }
    }
}

struct MultiSelectionButton: View {
    
    let content: String
    let icon : String
    let variableValue : CGFloat
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: icon, variableValue: variableValue)
                    .imageScale(.large) // Adjust size
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.duoBlue)
                    .font(.largeTitle)
                Text(content)
                    .font(.title3)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(isSelected ? .duoBlue : .primary)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(isSelected ? Color.duoBlue.opacity(0.1) : .clear)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.duoBlue : Color.paleGray, lineWidth: 2)
            )
            .padding(.horizontal)
        }
        .onTapGesture {
            action()
        }
    }
}



#Preview {
    GeneralKnowledgeLevelView()
}


#Preview {
    MultiSelectionButton(content: "Super easy", icon: "chart.bar.fill", variableValue: 0.5, isSelected: false) {}
}
