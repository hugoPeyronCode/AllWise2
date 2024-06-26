//
//  ContinueButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 15/11/2023.
//
import SwiftUI

struct ContinueButton: View {
    
    let content: String
    let backgroundColor: Color
    let shadowGroundColor: Color
    var action: () -> Void
    
    @State private var offset: CGFloat = 2
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(shadowGroundColor.dark)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .offset(y: offset) 
            
            Text(content.uppercased())
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.white)
                .font(.body)
                .bold()
                .fontDesign(.rounded)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(y: -offset)
        }
        .contentShape(RoundedRectangle(cornerRadius: 15))
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    self.offset = 0
                })
                .onEnded({ _ in
                    withAnimation(.snappy){
                        self.offset = 2
                        action()
                    }
                })
        )
    }
}

struct ContinueButton_Previews: PreviewProvider {
    static var previews: some View {
        ContinueButton(content: "Continue", backgroundColor: .blue, shadowGroundColor: .darkBlue, action: { print("Button tapped") })
    }
}
