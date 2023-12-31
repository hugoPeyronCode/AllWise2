//
//  TopicButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct TopicButton: View {
    
    @ObservedObject var vm = AppViewModel.shared
    @ObservedObject var lifesManager = LifesManager.shared
    
    var topic: Topic
    
    let lessonColor : Color
    
    @State var progress: Double = 0
    
    @State var action : () -> Void
    
    @State var offset: CGFloat = 2
        
    var body: some View {
            ZStack {
                
                CircularProgressView(progress: progress, color: color(), fontSize: .body, lineWidth: 8, withText: false)
                    .frame(height: 90)
                
                ZStack {
                    
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(accentColor())
                        .offset(y: offset)
                    
                    Image(systemName: icon())
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(topic.state == .isLocked ? .black.opacity(0.1) : .white)
                        .padding()
                        .background(color())
                        .clipShape(Circle())
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .frame(width: 70, height: 70)
                        .offset(y: -offset)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        self.offset = 0
                    })
                    .onEnded({ _ in
                        withAnimation(.snappy){
                            self.offset = 2
                            if lifesManager.hasEnoughLifes {
                                action()
                            } else {
                                lifesManager.triggerModal = true
                            }
                        }
                    })
            )
            .onAppear{
            withAnimation(.snappy(duration: 5)){
                progress = calculateProgress()
            }
            
            if progress == 1 {
                print("Mark topic as solve")
                vm.markTopicAsSolved(topic.id)
            }
                
        }
    }
    
    func calculateProgress() -> Double {
        let totalSubtopics = Double(topic.subtopics.count)
        let solvedSubtopics = Double(topic.subtopics.filter { $0.isSolved }.count)
        return solvedSubtopics / totalSubtopics
    }
    
    
    func color() -> Color {
        switch topic.state {
        case .current:
            return lessonColor
        case .isLocked:
            return .paleGray
        case .isValidated:
            return .duoGreen
        }
    }
    
    func accentColor() -> Color {
        switch topic.state {
        case .current:
            return lessonColor.dark
        case .isLocked:
            return .gray
        case .isValidated:
            return .darkGreen
        }
    }
    
    func icon() -> String {
        switch topic.state {
        case .current:
            return "star.fill"
        case .isLocked:
            return "star.fill"
        case .isValidated:
            return "checkmark"
        }
    }
 
}

#Preview {
    topicButtonTestView()
}


struct topicButtonTestView : View {
    var body: some View {
        VStack {
            TopicButton(topic: Topic(name: "", subtopics: [SubTopic(name: "", questions: [], isSolved: true)], isSolved: false, state: .current), lessonColor: .blue, action: {})
            TopicButton(topic: Topic(name: "", subtopics: [], isSolved: false, state: .isLocked),  lessonColor: .blue, action: {})
                .padding()
            TopicButton(topic: Topic(name: "", subtopics: [], isSolved: true, state: .isValidated), lessonColor: .blue, action: {})
        }

    }
}
