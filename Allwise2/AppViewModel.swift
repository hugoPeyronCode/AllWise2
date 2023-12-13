//
//  AppViewModel.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import Foundation
import SwiftUI

class AppViewModel : ObservableObject {
    
    static let shared = AppViewModel()
    
    @Published var lessons : [Lesson] = mockData // Main array of data. Contain all the lessons, topics, subtopics, questions, answers
    
    // QUESTIONS
    // Function to find a question in a subTopic from its ID
    
    // Function to mark a question as solved
    func markQuestionAsSolved(for questionId: UUID) {
        for lessonIndex in lessons.indices {
            for topicIndex in lessons[lessonIndex].topics.indices {
                for subTopicIndex in lessons[lessonIndex].topics[topicIndex].subtopics.indices {
                    if let questionIndex = lessons[lessonIndex].topics[topicIndex].subtopics[subTopicIndex].questions.firstIndex(where: { $0.id == questionId }) {
                        // Mark the question as solved
                        lessons[lessonIndex].topics[topicIndex].subtopics[subTopicIndex].questions[questionIndex].isSolved = true
                        print(" Question marked as solved")
                        // If needed, perform additional actions, such as marking subtopic as solved if all questions are solved
                        updateSubTopicStateIfNeeded(forLesson: lessonIndex, forTopic: topicIndex, forSubTopic: subTopicIndex)
                        print("updated \(topics[topicIndex].name) state")
                        return
                    }
                }
            }
        }
        print("Could not find question.")
    }
    
    private func updateSubTopicStateIfNeeded(forLesson lessonIndex: Int, forTopic topicIndex: Int, forSubTopic subTopicIndex: Int) {
        let subTopicQuestions = lessons[lessonIndex].topics[topicIndex].subtopics[subTopicIndex].questions
        if subTopicQuestions.allSatisfy({ $0.isSolved }) {
            lessons[lessonIndex].topics[topicIndex].subtopics[subTopicIndex].isSolved = true
        }
    }
    
    // Function to get the number of all questions solved
    func totalNumberOfSolvedQuestions() -> Int {
        
        var solvedQuestionsCount = 0

        for lesson in lessons {
            for topic in lesson.topics {
                for subTopic in topic.subtopics {
                    solvedQuestionsCount += subTopic.questions.filter { $0.isSolved }.count
                    print("SolvedQuestionCount for \(lesson.name) \(topic.name) \(subTopic.name) = \(solvedQuestionsCount)")
                }
            }
        }

        return solvedQuestionsCount
    }
    
    // SUBTOPICS
    
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
    func questions(forSubTopicId subTopicId: UUID) -> [any Question] {
        for topic in topics {
            if let subTopic = topic.subtopics.first(where: { $0.id == subTopicId }) {
                return subTopic.questions
            }
        }
        return []
    }
    
    // TOPIC
    // Computed property to get all topics from all lessons
    var topics: [Topic] {
        return lessons.flatMap { $0.topics }
    }
    
    // Function to get all topics for a specific lesson
    func topics(forLessonId lessonId: UUID) -> [Topic] {
        guard let lesson = lessons.first(where: { $0.id == lessonId }) else {
            print("Lesson not found")
            return []
        }
        return lesson.topics
    }
    
    func markTopicAsSolved(_ topicId: UUID) {
        if let lessonIndex = lessons.firstIndex(where: { $0.topics.contains(where: { $0.id == topicId }) }),
           let topicIndex = lessons[lessonIndex].topics.firstIndex(where: { $0.id == topicId }) {
            print("Mark \(lessons[lessonIndex].topics[topicIndex].name) as solved!")
            lessons[lessonIndex].topics[topicIndex].isSolved = true
            lessons[lessonIndex].topics[topicIndex].state = .isValidated
            makeFirstUnSolvedTopicStateToCurrent(lessonId: lessons[lessonIndex].id)
        }
    }
    
    func makeFirstUnSolvedTopicStateToCurrent(lessonId: UUID) {
        if let lessonIndex = lessons.firstIndex(where: { $0.id == lessonId }) {
            var foundFirstUnsolved = false
            for topicIndex in lessons[lessonIndex].topics.indices {
                if !foundFirstUnsolved && !lessons[lessonIndex].topics[topicIndex].isSolved {
                    lessons[lessonIndex].topics[topicIndex].state = .current
                    foundFirstUnsolved = true
                    print("Updated \(lessons[lessonIndex].topics[topicIndex].name) state")
                } else {
                    lessons[lessonIndex].topics[topicIndex].state = foundFirstUnsolved ? .isLocked : .isValidated
                }
            }
        }
    }
    
    // LESSONS
    
    // Function to find a lesson in Lessons array from its ID
    func findLesson(by lessonId: UUID) -> Lesson {
        return lessons.first { $0.id == lessonId } ?? Lesson(name: "Error", image: "❌", color: .black, topics: [])
    }

    
    // Function to mark a lesson as solved
    
    
    // Function to get the progress of a lesson -> number of topic solved on total number of topic of a lesson
    func progressOfLesson(lessonId: UUID) -> Double {
        guard let lesson = lessons.first(where: { $0.id == lessonId }) else {
            print("Lesson not found")
            return 0
        }

        let totalTopics = lesson.topics.count
        guard totalTopics > 0 else {
            return 0 // Avoid division by zero
        }

        let solvedTopics = lesson.topics.filter { $0.isSolved }.count
        return Double(solvedTopics) / Double(totalTopics)
    }
    
    
    // TOPICS
    
    // Function to find a Topic in a Lesson form is ID
    
    // Function to make a topic as solved
    
    // Function to get the progress of a topic -> number of subTopic solved on total number of subtopic of a Topic
    
    
    // SUBTOPICS
    
    // Function to find a subTopic in a Topc its ID
    
    // Function to make a subTopic as solved
    
    // Function to get the progress of a subtopic -> number of questions solved on total number of subtopic of a Topic.
    
    
    // EXTRA RESEARCH FONCTION
    
    // Find a question from it's UUID.
    func findQuestion(for questionId: UUID) -> (any Question)? {
        for lesson in lessons {
            for topic in lesson.topics {
                for subTopic in topic.subtopics {
                    if let question = subTopic.questions.first(where: { $0.id == questionId }) {
                        return question
                    }
                }
            }
        }
        return nil
    }

    
    // Go to Lesson -> Topic -> Subtopic -> Question
}
