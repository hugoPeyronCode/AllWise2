//
//  AppViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import Foundation

class AppViewModel : ObservableObject {
    @Published var lessons : [Lesson] = mockData
    
    @Published var lifesCounter : Int = 5
    
    @Published var dailyStreak : Int = 0
    
    // Computed property to get all topics from all lessons
    var topics: [Topic] {
        return lessons.flatMap { $0.topics }
    }
    
    // Function to get subtopics for a specific topic
    func subtopics(forTopicId topicId: UUID) -> [SubTopic] {
        guard let topic = topics.first(where: { $0.id == topicId }) else {
            return []
        }
        return topic.subtopics
    }
    
    // Function to find the first unsolved subtopic within a topic
     func firstUnsolvedSubTopic(topicId: UUID) -> SubTopic? {
         for lesson in lessons {
             if let topic = lesson.topics.first(where: { $0.id == topicId }) {
                 return topic.subtopics.first(where: { !$0.isSolved })
             }
         }
         return nil
     }
        
    // Function to get questions for a specific subtopic
    func questions(forSubTopicId subTopicId: UUID) -> [Question] {
        for topic in topics {
            if let subTopic = topic.subtopics.first(where: { $0.id == subTopicId }) {
                return subTopic.questions
            }
        }
        return []
    }
    
    
    // TOPIC
    func markTopicAsSolved(_ topicId: UUID) {
        if let lessonIndex = lessons.firstIndex(where: { $0.topics.contains(where: { $0.id == topicId }) }),
           let topicIndex = lessons[lessonIndex].topics.firstIndex(where: { $0.id == topicId }) {
            lessons[lessonIndex].topics[topicIndex].isSolved = true
        }
    }
    
    func updateTopicsState() {
         var foundFirstUnsolved = false
         
         for lessonIndex in lessons.indices {
             for topicIndex in lessons[lessonIndex].topics.indices {
                 if !foundFirstUnsolved && !lessons[lessonIndex].topics[topicIndex].isSolved {
                     // This is the first unsolved topic, mark it as current
                     lessons[lessonIndex].topics[topicIndex].state = .current
                     foundFirstUnsolved = true
                 } else {
                     // All other topics are marked as locked
                     lessons[lessonIndex].topics[topicIndex].state = foundFirstUnsolved ? .isLocked : .isValidated
                 }
             }
         }
     }
}
