//
//  OnboardingView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            
            
            Text("Hello, World!")
            
            
            ValidationButton(questionState: .isValid) {
                // vm.moveToNextPage
            }
        }
    }
}

#Preview {
    OnboardingView()
}
