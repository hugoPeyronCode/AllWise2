//
//  ErrorsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 15/11/2023.
//

import SwiftUI

struct ErrorsView: View {
    
//    @Environment(\.dismiss) private var dismiss
    
    @State var action : () -> Void
    
    var body: some View {
        VStack {
            
            
            Spacer()
            Text("😄")
                .font(.largeTitle)
                .scaleEffect(2)
                .padding()
            
            Text("Let's correct the exercices you've missed!")
            
            Spacer()
            
            Button(action: {action()}, label: {
                
                Text("Continue")
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .bold()
                    .fontDesign(.rounded)
                    .background(Color.duoGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
            })
            
        }
    }
}

#Preview {
    ErrorsView(action: {})
}
