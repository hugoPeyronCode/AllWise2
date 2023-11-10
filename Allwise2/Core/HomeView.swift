//
//  HomeView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TopicsView()
                    .environmentObject(vm)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    LessonSelectionButton
                }
                
                ToolbarItem(placement: .principal) {
                    StreakCounterView
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    LifesCounterView
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Image(systemName: "person")
                }
            }
        }
    }
    
    var LessonSelectionButton : some View {
        Text("📕")
            .font(.title)
    }
    
    var StreakCounterView : some View {
        HStack {
            Text("🔥")
                .font(.title2)
            Text("15")
                .font(.system(.body, design: .rounded, weight: .black))
                .foregroundStyle(.gray.opacity(0.4))
        }
        
    }
    
    var LifesCounterView : some View {
        HStack {
            Text("❤️")
                .font(.title2)
            Text("5")
                .font(.system(.body, design: .rounded, weight: .black))
                .foregroundStyle(.gray.opacity(0.4))
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(AppViewModel())
}
