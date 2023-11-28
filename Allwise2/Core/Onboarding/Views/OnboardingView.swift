//
//  OnboardingView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var currentStep = 1
    
    var body: some View {
        NavigationStack{
            VStack{
                switch currentStep {
                case 1:
                    SelectFirstLessonView() {
                        withAnimation {
                            currentStep = 2
                        }
                    }
                    .transition(.slide)
                    
                case 2:
                    GeneralKnowledgeLevelView() {
                        withAnimation {
                            currentStep = 3
                            
                        }
                    }
                    .transition(.slide)
                    
                    
                case 3:
                    SelfImprovementReasonsView() {
                        withAnimation {
                            currentStep = 4
                        }
                    }
                    .transition(.slide)
                    
                    
                case 4:
                    WhatYouCanAchieveView() {
                        withAnimation {
                            currentStep = 5
                        }
                    }
                    .transition(.slide)
                default:
                    SelectFirstLessonView(){}
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if currentStep > 1 {
                        Image(systemName: "chevron.left")
                            .bold()
                            .foregroundStyle(.paleGray)
                            .onTapGesture {
                                if currentStep > 1 {
                                    currentStep -= 1
                                }
                            }
                    }
                }

                ToolbarItem(placement: .principal) {
                    CustomProgressBar(progress: Float(currentStep) / 5)
                        .frame(width: 240, height: 10)
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
