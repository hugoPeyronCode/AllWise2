//
//  Consigne.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct Consigne: View {
    
    let text : String
    
    var body: some View {
        Text(text.uppercased())
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .fontDesign(.monospaced)
    }
}

#Preview {
    Consigne(text: "Test")
}
