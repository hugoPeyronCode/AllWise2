//
//  TopicsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct TopicsView: View {
    // Data
    //    @EnvironmentObject var vm: AppViewModel
    @ObservedObject var vm = AppViewModel.shared
    
    // Selection
    @State private var selectedSubTopic: SubTopic?
    
    // Navigation
    @State private var isNavToSubTopicView = false
    
    let lesson : Lesson
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 30) {
                    ForEach(lesson.topics, id: \.id) { topic in
                        TopicButton(
                            topic: topic,
                            lessonColor: lesson.color) {
                            selectedSubTopic = vm.firstUnsolvedSubTopic(topicId: topic.id)
                            isNavToSubTopicView = selectedSubTopic != nil
                        }
                        .disabled(topic.state == .isLocked)
                        
                        Text(topic.name)
                            .font(.title3)
                            .fontDesign(.rounded)
                            .bold()
                            .foregroundStyle(color(topicState: topic.state))
                        
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 10, height: 50)
                            .foregroundStyle(color(topicState: topic.state))

                    }
                    
                    // End of session Button
                    CircularProgressView(progress: vm.progressOfLesson(lessonId: lesson.id), color: .blue)
                    .frame(height: 200)
                
                Text("\(lesson.name) Complete")
                    .font(.title3)
                    .fontDesign(.rounded)
                    .bold()
            }
            .navigationDestination(isPresented: $isNavToSubTopicView) {
                if let subTopicToNavigate = selectedSubTopic {
                    SubTopicView(subTopic: subTopicToNavigate) { result in
                        if result == true {
                            vm.makeFirstUnSolvedTopicStateToCurrent(lessonId: lesson.id )
                        }
                    }
                    //                    .environmentObject(vm)
                }
            }
        }
        .onAppear{
            // Make the last not solved topic state to current and update it's progression
            print("Topic View Appears")
            vm.makeFirstUnSolvedTopicStateToCurrent(lessonId: lesson.id )
        }
    }
    
    func color(topicState : TopicState) -> Color {
        switch topicState {
        case .current:
            return .duoBlue
        case .isLocked:
            return .paleGray
        case .isValidated:
            return .duoGreen
        }
    }
}


#Preview {
    TopicsView(lesson: AppViewModel.shared.lessons.first!)
}


