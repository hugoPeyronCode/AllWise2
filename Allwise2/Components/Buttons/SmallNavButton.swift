//
//  SmallNavButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/11/2023.
//

import SwiftUI

struct SmallNavButton: View {
    
    let icon : String
    let text: String
    let mainColor : Color
    
    let action : () -> Void
    
    @State var offset : CGFloat = 2
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: icon)
                    .foregroundStyle(mainColor.dark)
                    .frame(width: 50, height: 40)
                    .background(mainColor.dark)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .offset(y: offset)
                
                Image(systemName: icon)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 40)
                    .background(mainColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .offset(y: -offset)
            } 
            
            Text(text)
                .font(.caption2)
                .bold()
                .foregroundStyle(.foreground)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    withAnimation(.snappy){
                        self.offset = 0
                    }
                })
                .onEnded({ _ in
                    withAnimation(.snappy){
                        withAnimation(.snappy){
                        self.offset = 2
                            action()
                        }
                    }
                })
    )
    }
}

#Preview {
    SmallNavButton(icon: "person.fill", text: "Profil", mainColor: .darkBlue, action: {})
}
