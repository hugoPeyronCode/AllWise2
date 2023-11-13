//
//  TopicButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import SwiftUI

struct TopicButton: View {
    
    @EnvironmentObject var vm : AppViewModel
    
    var topic: Topic
    
    var progress: Double { calculateProgress() }
    
    @State var action : () -> Void
        
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                CircularProgressView(progress: progress, color: .cyan, fontSize: .body, lineWidth: 10, withText: false)
                
                Image(systemName: topic.state == .current ? "star" :  topic.state == .isLocked ? "xmark" : "star.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .padding()
                    .background(topic.state == .current ? .cyan : topic.state == .isLocked ? .gray : .green)
                    .clipShape(Circle())
                    .font(.system(.largeTitle, design: .rounded, weight: .black))
                    .shadow(color: .blue.opacity(0.5), radius: 5)
            }
            .frame(width: 70, height: 70)
        }
        .onAppear{
            if progress == 1 {
                vm.markTopicAsSolved(topic.id)
            }
        }
    }

    
    func calculateProgress() -> Double {
        let totalSubtopics = Double(topic.subtopics.count)
        let solvedSubtopics = Double(topic.subtopics.filter { $0.isSolved }.count)
        return solvedSubtopics / totalSubtopics
    }
 
}

#Preview {
    TopicButton(topic: Topic(name: "", subtopics: [], isSolved: true, state: .isLocked), action: {})
        .environmentObject(AppViewModel())
}
