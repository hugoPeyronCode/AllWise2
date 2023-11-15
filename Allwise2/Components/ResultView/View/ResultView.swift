//
//  ResultView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 15/11/2023.
//

import SwiftUI

enum LessonPerformance {
    case superFast
    case perfect
    case normal
    
    private static let perfectMessages = [
        "Perfect lesson!",
        "Flawless victory!",
        "Absolute perfection!",
        "100% accuracy!",
        "Spot on!"
    ]

    private static let superFastMessages = [
        "Super Fast!",
        "Speedy success!",
        "Quick thinking!",
        "Rapid response!",
        "Lightning speed!"
    ]

    private static let encouragementMessages = [
        "Great effort!",
        "Well done!",
        "Nice work!",
        "Keep it up!",
        "Solid attempt!"
    ]

    var titleText: String {
        switch self {
        case .perfect:
            return LessonPerformance.perfectMessages.randomElement() ?? "Perfect lesson!"
        case .superFast:
            return LessonPerformance.superFastMessages.randomElement() ?? "Super Fast!"
        default:
            return LessonPerformance.encouragementMessages.randomElement() ?? "Great job!"
        }
    }

    var subtitleText: String {
        switch self {
        case .perfect, .superFast:
            return "Take a bow!"
        default:
            return "Keep going!"
        }
    }

    var mainColor: Color {
        switch self {
        case .perfect:
            return .green
        case .superFast:
            return .blue
        default:
            return .secondary
        }
    }

    var buttonColor: Color {
        switch self {
        case .perfect, .superFast:
            return .blue
        default:
            return .secondary
        }
    }
}

struct ResultView: View {
    
    let accuracy: Double // % of correctness 1 = 100%
    let speed: Int // duration of the session in seconds
    let totalXP: Int // xp earned (+15 per xp)

    var performance: LessonPerformance {
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
            Text(performance.titleText)
                .font(.largeTitle)
                .bold()
                .foregroundColor(performance.mainColor)
            
            Text(performance.subtitleText)
                .font(.title2)
                .foregroundColor(.gray)
            
            HStack(spacing: 20) {
                ResultViewWidget(title: "TOTAL XP", value: "\(totalXP)", performance: performance)
                ResultViewWidget(title: "SPEEDY", value: String(format: "%d:%02d", speed / 60, speed % 60), performance: performance)
                ResultViewWidget(title: "AMAZING", value: "\(Int(accuracy * 100))%", performance: performance)
            }
            
            Button(action: {
                // Action for continue button
            }) {
                Text("CONTINUE")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(performance.buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct ResultViewWidget: View {
    
    let title: String
    let value: String
    let performance: LessonPerformance
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(performance == .normal ? .black : .white)
            Text(value)
                .font(.title)
                .bold()
                .foregroundColor(performance == .normal ? .black : .white)
        }
        .padding()
        .background(performance.mainColor.opacity(performance == .normal ? 0.6 : 1.0))
        .cornerRadius(10)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(accuracy: 0.75, speed: 178, totalXP: 15)
    }
}
