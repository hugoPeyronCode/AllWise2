//
//  ResultOverlay.swift
//  Allwise2
//
//  Created by Hugo Peyron on 14/11/2023.
//

import SwiftUI

struct ResultOverlay: View {
    var message: String
    var explanation: String
    var iconName: String
    var backgroundColor: Color
    var textColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: iconName)
                Text(message)
                Spacer()
            }
            .font(.title)
            .bold()
            
            Text(explanation)
                .bold()
                .font(.body)
            
            VStack{
                
            }
            .frame(height: 50)
        }
        .fontDesign(.rounded)
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundColor(textColor)
    }
}


#Preview {
    ResultOverlay(message: "Correct", explanation: "You must be wrong because the real message is definitely something else. ", iconName: "heart.fill", backgroundColor: .paleGreen, textColor: .duoGreen)
}
