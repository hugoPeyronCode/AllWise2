//
//  ResultView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 15/11/2023.
//

import SwiftUI

struct ResultView: View {
    
    let accuracy: Double // % of correctness 1 = 100%
    let speed: Int // duration of the session in seconds
    let totalXP: Int // xp earned (+15 per xp)
    
    @State var action : () -> Void

    var vm: ResultViewModel {
        if accuracy == 1.0 {
            return .perfect
        } else if speed <= 120 {
            return .superFast
        } else {
            return .normal
        }
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            Spacer()
            
            Text(vm.titleText)
                .font(.largeTitle)
                .bold()
                .foregroundColor(vm.mainColor)
            
            Text(vm.subtitleText)
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.bottom, 50)
            
            
            HStack(spacing: 20) {
                // XP widget always yellow
                ResultViewWidget(title: "TOTAL XP", value: "\(totalXP)", icon: "bolt.fill", color: .yellow)
                // Speed widget always blue
                ResultViewWidget(title: "SPEEDY", value: String(format: "%d:%02d", speed / 60, speed % 60), icon: "timer", color: .blue)
                // Accuracy widget always green
                ResultViewWidget(title: "AMAZING", value: "\(Int(accuracy * 100))%", icon: "scope", color: .green)
            }
            .padding()
            
            Spacer()
            
            ContinueButton(content: "Continue", backgroundColor: .duoBlue, shadowGroundColor: .darkBlue, action: {action()})
        }
        .fontDesign(.rounded)
    }
}


struct ResultViewWidget: View {
    
    let title: String
    let value: String
    let icon : String
    let color: Color // Color is now passed as a parameter directly
    
    var body: some View {
        VStack {
            Text(title)
                .font(.callout)
                .bold()
                .foregroundStyle(.white)
                .offset(y: 3)
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.white)

                HStack {
                    Image(systemName: icon)
                    Text(value)
                        .font(.body)
                        .bold()
                }
                .foregroundStyle(color)

            }
        }
        .padding(3)
        .frame(maxHeight: 90)
        .background(color)
        .cornerRadius(15)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(accuracy: 1, speed: 70, totalXP: 15, action: {})
    }
}
