//
//  HeaderGradient.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct HeaderGradient: View {
    var body: some View {
        VStack {
            LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom)
                .frame(height: SizeConstants.screenHeight * 0.3)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HeaderGradient()
}
