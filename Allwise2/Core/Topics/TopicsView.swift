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
                ForEach(vm.topics.indices, id: \.self) { index in
                    TopicButton(topic: vm.topics[index]) {
                        selectedSubTopic = vm.firstUnsolvedSubTopic(topicId: vm.topics[index].id)
                        isNavToSubTopicView = selectedSubTopic != nil
                    }
                    .offset(x: index % 2 == 0 ? 50 : -50)
                    .disabled(vm.topics[index].state == .isLocked)
                }
            }
            .navigationDestination(isPresented: $isNavToSubTopicView) {
                if let subTopicToNavigate = selectedSubTopic {
                    SubTopicView(subTopic: subTopicToNavigate) { result in
                        if result == true {
                            vm.updateTopicsState()
                        }
                    }
                    .environmentObject(vm)
                }
            }
        }
        .onAppear{
            // Make the last not solved topic state to current and update it's progression
            vm.updateTopicsState()
            print("view appears")
        }
    }
}


#Preview {
    TopicsView()
        .environmentObject(AppViewModel())
}


