//
//  TopicsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

class TopicsViewViewModel : ObservableObject {
    func modifyOffset(for topic: Topic, at index: Int) -> CGFloat {
        if topic.isSolved {
            return 0
        } else {
            // Alternate the offset based on whether the index is odd or even
            return index % 2 == 0 ? -30 : 30
        }
    }
}

struct TopicsView: View {
    
    // Main viewModel with all data and logic
    @EnvironmentObject var vm: AppViewModel
    
    // Local ViewModel for small view twick
    @StateObject var localVM = TopicsViewViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 30) {
                ForEach(Array(zip(vm.topics.indices, vm.topics)), id: \.1.id) { (index, topic) in
                    TopicButton(topic: topic)
                        .offset(x: localVM.modifyOffset(for: topic, at: index))
                }
            }
        }
    }
}

#Preview {
    TopicsView()
        .environmentObject(AppViewModel())
}


struct TopicButton: View {
    
    @EnvironmentObject var vm: AppViewModel
    var topic: Topic

    var body: some View {
        Button {
            vm.markTopicAsSolved(topic.id)
        } label: {
            Image(systemName: topic.isSolved ? "checkmark" : "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
                .padding()
                .background(topic.isSolved ? Color.green : Color.orange)
                .clipShape(Circle())
                .font(.system(.largeTitle, design: .rounded, weight: .black))
                .shadow(color: .blue.opacity(0.5), radius: 5)
        }
    }
}
