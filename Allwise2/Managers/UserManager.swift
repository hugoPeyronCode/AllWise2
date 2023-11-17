//
//  UserManager.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/11/2023.
//

import Foundation
import SwiftUI

class UserManager : ObservableObject {
    
    @ObservedObject var appViewModel = AppViewModel.shared
    
    static let shared = UserManager()
    @Published var bestDayStreakCount = 0
    @Published var xp : Int = 0
    @Published var level : UserLevel = .Freshman
    @Published var image : String = "sadOwl"
    @Published var name : String = "Hugo"
    
}

enum UserLevel : String, CaseIterable {
    case Freshman
    case Sophomore
    case Junior
    case Senior
    case Bachelor
    case Master
    case Doctor
    case Professor
    
    var icon: String {
        switch self {
        case .Freshman:
            return "freshmanIcon"
        case .Sophomore:
            return "sophomoreIcon"
        case .Junior:
            return "juniorIcon"
        case .Senior:
            return "seniorIcon"
        case .Bachelor:
            return "bachelorIcon"
        case .Master:
            return "masterIcon"
        case .Doctor:
            return "doctorIcon"
        case .Professor:
            return "professorIcon"
        }
    }
    
    var color: Color {
        switch self {
        case .Freshman:
            return .gray
        case .Sophomore:
            return .cyan
        case .Junior:
            return .mint
        case .Senior:
            return .orange
        case .Bachelor:
            return .green
        case .Master:
            return .purple
        case .Doctor:
            return .pink
        case .Professor:
            return .yellow
        }
    }
}
