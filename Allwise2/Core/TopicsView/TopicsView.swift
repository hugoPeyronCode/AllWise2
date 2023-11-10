//
//  TopicsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct TopicsView: View {
    // Data
    @EnvironmentObject var vm: AppViewModel
    
    // Selection
    @State private var selectedSubTopic: SubTopic?
    
    // Navigation
    @State private var isNavToSubTopicView = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 30) {
                ForEach(vm.topics, id: \.id) { topic in
                    TopicButton(topic: topic) {
                        selectedSubTopic = vm.firstUnsolvedSubTopic(topicId: topic.id)
                        isNavToSubTopicView = selectedSubTopic != nil
                    }
                    .disabled(topic.state == .isLocked)
                }
            }
            .navigationDestination(isPresented: $isNavToSubTopicView) {
                if let subTopicToNavigate = selectedSubTopic {
                    SubTopicView(subTopic: subTopicToNavigate)
                        .environmentObject(vm)
                }
            }
        }
        .onAppear{
            // Make the last not solved topic state to current
            vm.updateTopicsState()
            print("view appears")
        }
    }
}


#Preview {
    TopicsView()
        .environmentObject(AppViewModel())
}


