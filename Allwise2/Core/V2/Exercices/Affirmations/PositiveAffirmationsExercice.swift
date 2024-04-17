//
//  PositiveAffirmationsExercice.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 16/04/2024.
//

import SwiftUI

struct PositiveAffirmationsExercice: View {
    let affirmations = [
        "I am beautiful",
        "I am enough",
        "I am a good person",
        "I am strong and capable",
        "I am worthy of respect and acceptance",
        "My confidence grows stronger every day",
        "I am loved and appreciated",
        "I believe in my ability to succeed",
        "I am in charge of my happiness",
        "I possess the qualities needed to be extremely successful",
        "I am at peace with my past",
        "I am grateful for all that I have",
        "I am excited about the future",
        "I choose to be kind to myself and love myself unconditionally",
        "My potential to succeed is limitless"
    ]
    
    @State var selectedAffirmations: [String] = []
    @State var revealedAffirmations: Set<Int> = []
    @State var progressBarFill: Double = 0.0
    @State var showFinishButton = false
    @State var animateButton = false
    let totalAffirmations = 5
    
    @State private var showQuitOverlay = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    ExerciceSubtitle(emoji: "🌞", subtitle: "POSITIVE AFFIRMATIONS", subtitleColor: Color(red: 255 / 255.0, green: 205 / 255.0, blue: 42 / 255.0))
                        .padding([.top, .bottom], 20)
                    Spacer()
                }
                Text("TAKE A MOMENT TO RECHARGE")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 117 / 255.0, green: 117 / 255.0, blue: 117 / 255.0))
                    .padding([.top, .bottom], 20)
                
                // Affirmations
                ForEach(Array(selectedAffirmations.enumerated()), id: \.element) { index, affirmation in
                                    ScratchCard(
                                        affirmation: affirmation,
                        index: index,
                        revealedAffirmations: $revealedAffirmations,
                        progress: $progressBarFill,
                        total: CGFloat(totalAffirmations)
                                    )                    .padding([.top, .bottom], 5)

                }
                // Finish Button
                if showFinishButton {
                    Button(action: {
                        // Finishg button action
                        print("Button clicked")
                        dismiss()

                    }) {
                        HStack {
                            Spacer()
                            
                            Text("Finish")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .padding(10)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)

                        .background(Color("paleGray"))
                        .cornerRadius(10)
                        .scaleEffect(animateButton ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.4), value: animateButton)
                        
                    }
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing], 20)

                }
                
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            
            .onAppear {
                progressBarFill = 0
                selectedAffirmations = Array(affirmations.shuffled().prefix(totalAffirmations))

            }
            .onChange(of: revealedAffirmations) { _ in
                if revealedAffirmations.count == totalAffirmations {
                    showFinishButton = true
                    animateButton = true                        }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                XMark
            }
            ToolbarItem(placement: .principal) {
                ExerciceProgressBar_2(progress: $progressBarFill)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
    
    var XMark: some View {
        Button {
            withAnimation(.snappy){
                showQuitOverlay.toggle()
                dismiss()
                
            }
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .bold()
                .font(.title3)
        }
    }
}

#Preview {
    PositiveAffirmationsExercice()
}
