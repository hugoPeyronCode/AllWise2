//
//  UserDashboardView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/11/2023.
//

import SwiftUI


enum userDataType : String, CaseIterable {
    case level
    case xp
    case bestDayStreak
    case questionMastered
}

struct UserDashboardView: View {
    
    @ObservedObject var appViewModel = AppViewModel.shared
    @ObservedObject var userManager = UserManager.shared
    
    var body: some View {
        ScrollView {
            Image("sadOwl")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .ignoresSafeArea()
            
            HStack {
                Text(userManager.name)
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                Spacer()
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Stats")
                        .bold()
                    Spacer()
                }
                HStack {
                    userInfoButton(type: .level)
                    userInfoButton(type: .xp)
                }
                HStack {
                    userInfoButton(type: .bestDayStreak)
                    userInfoButton(type: .questionMastered)
                }
            }
            .padding()
            
            Divider()
            
            VStack {
                HStack{
                    Text("Progress")
                        .bold()
                    Spacer()
                }
                
                ForEach(appViewModel.lessons, id: \.id) { lesson in
                    HStack {
                        Button {
                            // some code
                        } label: {
                            ProgressView(lesson.name, value: appViewModel.progressOfLesson(lessonId: lesson.id))
                                .progressViewStyle(.linear)
                                .foregroundStyle(.foreground)
                                .fontWeight(.bold)
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                
            }
            .padding()
            
        }
    }
}


struct userInfoButton : View {
    
    @ObservedObject var appViewModel = AppViewModel.shared
    @ObservedObject var userManager = UserManager.shared
    
    let type : userDataType
    
    var body: some View {
        Button {
            // Action
        } label: {
            HStack{
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(color)
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                    Text(subtitle)
                        .font(.caption2)
                }
                .foregroundStyle(.foreground)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(height: 60)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    var icon: String {
        switch type {
        case .level:
            return "shield.fill"
        case .xp:
            return "star.fill"
        case .bestDayStreak:
            return "flame.fill"
        case .questionMastered:
            return "checkmark.circle.fill"
        }
    }
    
    var color: Color {
        switch type {
        case .level:
            return userManager.level.color
        case .bestDayStreak:
            return .orange
        case .questionMastered:
            return .green
        case .xp:
            return .yellow
        }
    }
    
    var title: String {
        switch type {
        case .level:
            return userManager.level.rawValue
        case .xp:
            return "\(userManager.xp)"
        case .bestDayStreak:
            return "\(userManager.bestDayStreakCount)"
        case .questionMastered:
            return "\(appViewModel.totalNumberOfSolvedQuestions())"
        }
    }
    
    var subtitle: String {
        switch type {
        case .level:
            return "Current level"
        case .xp:
            return "XP"
        case .bestDayStreak:
            return "Best Day Streak"
        case .questionMastered:
            return "Questions Mastered"
        }
    }
}

#Preview {
    UserDashboardView()
}
