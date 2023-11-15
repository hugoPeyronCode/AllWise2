//
//  ResultViewViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 15/11/2023.
//

import Foundation
import SwiftUI

enum ResultViewModel {
    case superFast
    case perfect
    case normal
    
    private static let perfectTitles = [
        "Perfect lesson!",
        "Flawless victory!",
        "Absolute perfection!",
        "100% accuracy!",
        "Spot on!"
    ]

    private static let superFastTitles = [
        "Super Fast!",
        "Speedy success!",
        "Quick thinking!",
        "Rapid response!",
        "Lightning speed!"
    ]

    private static let normalTitles = [
        "Great effort!",
        "Well done!",
        "Nice work!",
        "Keep it up!",
        "Solid attempt!"
    ]

    private static let perfectSubtitles = [
        "Take a bow!",
        "Outstanding!",
        "You nailed it!",
        "Exemplary work!",
        "Masterful!"
    ]

    private static let superFastSubtitles = [
        "Take a bow!",
        "Incredible pace!",
        "Efficiency at its best!",
        "Speed demon!",
        "Ahead of time!"
    ]

    private static let normalSubtitles = [
        "Keep going!",
        "On the right path!",
        "Making progress!",
        "Almost there!",
        "Good hustle!"
    ]
    
    var titleText: String {
        switch self {
        case .perfect:
            return ResultViewModel.perfectTitles.randomElement() ?? "Perfect lesson!"
        case .superFast:
            return ResultViewModel.superFastTitles.randomElement() ?? "Super Fast!"
        case .normal:
            return ResultViewModel.normalTitles.randomElement() ?? "Great effort!"
        }
    }

    var subtitleText: String {
        switch self {
        case .perfect:
            return ResultViewModel.perfectSubtitles.randomElement() ?? "Take a bow!"
        case .superFast:
            return ResultViewModel.superFastSubtitles.randomElement() ?? "Incredible pace!"
        case .normal:
            return ResultViewModel.normalSubtitles.randomElement() ?? "Keep going!"
        }
    }

    var mainColor: Color {
        switch self {
        case .perfect:
            return .yellow
        case .superFast:
            return .blue
        default:
            return .green
        }
    }

    var buttonColor: Color {
        switch self {
        case .perfect:
            return .yellow
        case .superFast:
            return .blue
        default:
            return .green
        }
    }
}
