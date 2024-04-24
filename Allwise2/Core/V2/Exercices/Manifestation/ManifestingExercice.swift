//
//  ManifestingExercice.swift
//  Allwise2
//
//  Created by Arthur GUERIN on 17/04/2024.
//

import SwiftUI

struct ManifestingExercice: View {
    let examples = ["I want to improve my health and fitness levels.",
                    "I want to find a new job that I am passionate about.",
                    "I want to create deeper relationships.",
                    "I want to develop a new skill, like learning a foreign language.",
                    "I want to achieve financial stability.",
                    "I want to buy a new home.",
                    "I want to start my own business",
                    "I want to travel to three new countries this year.",
                    "I want to volunteer regularly",
                    "I want to publish a book or a series of articles.",
                    "I want to speak confidently in public.",
                    "I want to cultivate a more positive mindset.",
                    "I want to complete a marathon.",
                    "I want to achieve a better work-life balance.",
                    " I want to learn how to cook."]
    
    @State private var exampleText = "I want to get that promotion."
    @State private var manifestationText = ""
    @State private var readyClicked = false
    @State private var repeatFinish = false

    @State private var currentExampleIndex = 0
    @State private var offset = CGSize.zero
    @State private var scaleEffect = 1.0
    @State private var count = 0
    
    @Environment(\.dismiss) private var dismiss
    
    let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    let scaleTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    //For progress bar filling
    @State private var progress = 0.0

    
    var body: some View {
        ZStack {
            ColorGradients.white
                    .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    ExerciceSubtitle(emoji: "🙌", subtitle: "MANIFESTATION", subtitleColor: Color(red: 255 / 255.0, green: 205 / 255.0, blue: 42 / 255.0))
                        .padding([.top, .bottom], 20)
                    Spacer()
                }
                Text("WRITE AND REPEAT")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 117 / 255.0, green: 117 / 255.0, blue: 117 / 255.0))
                    .padding([.top, .bottom], 20)
                if readyClicked == false {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Text("Write down what you want to manifest.")
                            .font(.callout)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20.0)
                        
                        Text("Example: \(exampleText)")
                            .font(.callout)
                              .fontWeight(.regular)
                              .foregroundColor(.black)
                              .offset(x: offset.width, y: 0)
                              .onReceive(timer) { _ in
                                  let nextIndex = examples.indices.randomElement() ?? currentExampleIndex
                                  // Start sliding out
                                  withAnimation(.easeInOut(duration: 0.4)) {
                                      offset = CGSize(width: -300, height: 0)
                                  }
                                  // After sliding out, reset position and set new text
                                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                      exampleText = examples[nextIndex]
                                      offset = CGSize(width: 300, height: 0)
                                      // Start sliding in
                                      withAnimation(.easeInOut(duration: 0.4)) {
                                          offset = CGSize.zero
                                      }
                                  }
                                  currentExampleIndex = nextIndex
                              }
                            .frame(width:300, height: 70)
                
                        TextField("Enter your manifestation here", text: $manifestationText)
                            .padding(10) // Padding inside the TextField
                            .background(Color.white) // Background color of the TextField
                            .cornerRadius(8) // Rounded corners
                            .foregroundColor(.black) // Text color
                            .padding(.horizontal, 10) // Padding around the TextField
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1) // Customizable border color
                            )
                            .frame(width: 300)
                        
                        Spacer() // Pushes all content to the top
                    }
                    .frame(maxHeight: SizeConstants.screenHeight / 2 )
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 75)
                        .stroke(Color.paleGray, lineWidth: 2)
                        .background(Color.white))
                    .onAppear {
                        progress = 0.7
                    }
                }
                else {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Text("Time to repeat your Manifestation")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20.0)
                        
                        Text("\(manifestationText)")
                            .font(.callout)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .scaleEffect(scaleEffect)
                            .onReceive(scaleTimer) { _ in
                                // Scale up
                                withAnimation(.easeInOut(duration: 2)) {
                                    scaleEffect = 2.0
                                }
                                
                                // Delay the scale down to start after the scale up completes
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    // Scale down
                                    withAnimation(.easeInOut(duration: 2)) {
                                        scaleEffect = 1.0
                                    }
                                }
                                
                                // Schedule counter increment to happen after the full animation cycle (5 seconds)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    if count < 20 {
                                        count += 1
                                        progress = (Double(count) * 0.05) + 0.045
                                    }
                                    if count > 20 {
                                        repeatFinish = true
                                        progress = 1.0
                                    }
                                }
                            }
                        Text("\(count)/20")
                            .frame(width: 250)
                            .foregroundColor(.black)

                            .padding()
                        
                        Spacer() // Pushes all content to the top
                    }
                    .frame(maxHeight: 400)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 75)
                        .stroke(Color.paleGray, lineWidth: 2)
                        .background(Color.white))
                }
                Button(action: {
                    // Finishg button action
                    print("Button clicked")
                    if readyClicked == false {
                        readyClicked.toggle()
                    }
                    else {
                        dismiss()
                    }
                }) {
                    if readyClicked == false || repeatFinish == true {
                        HStack {
                            Spacer()
                            
                            Text(readyClicked && repeatFinish ? "Finish":"Ready")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .padding(10)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        
                        .background(Color("paleGray"))
                        .cornerRadius(10)
                    }
                    
                }
                .padding([.top, .bottom], 20)
                .padding([.leading, .trailing], 20)
            }
            .padding([.leading, .trailing], 20)

        }
        .onDisappear {
            timer.upstream.connect().cancel()
            scaleTimer.upstream.connect().cancel()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                XMark
            }
            ToolbarItem(placement: .principal) {
                ExerciceProgressBar(progress: $progress)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
    var XMark: some View {
        Button {
            withAnimation(.snappy){
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
    ManifestingExercice()
}
