//
//  Allwise2App.swift
//  Allwise2
//  
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

@main
struct Allwise2App: App {
    
    @AppStorage("isShowingOnboarding") var isShowingOnboarding : Bool = true
    
    var body: some Scene {
        WindowGroup {
            
            MeditationView(progressBarViewModel: ProgressBarViewModel())
//            HomeView()
//                .fullScreenCover(isPresented: $isShowingOnboarding) {
//                    OnboardingView()                        
//                        .onDisappear {
//                            isShowingOnboarding = false
//                        }
//                }
            
        }
    }
}
