//
//  Models.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import Foundation
import SwiftUI

struct Answer: Identifiable {
    let id = UUID()
    let text: String
    let isTrue: Bool
}

protocol Question : Identifiable {
    var id: UUID { get }
    var isSolved: Bool { get set }
}

// Structure for QCM question
struct QCMQuestion: Question {
    let id = UUID()
    let question: String
    let image: String
    let explanation: String
    let answers: [Answer]
    var isSolved: Bool
}

struct MatchingQuestion: Question {
    let id = UUID()
    var questions : [QuestionAnswerPair]
    var isSolved: Bool
}

// Structure for question-answer pairs
struct QuestionAnswerPair : Identifiable {
    let id = UUID()
    var question: String
    var answer: String
    var questionState: QuestionState = .isNeutral
    var answerState: QuestionState = .isNeutral
}

struct SubTopic: Identifiable {
    let id = UUID()
    let name: String
    var questions: [any Question]
    var isSolved: Bool
}

struct Topic: Identifiable {
    let id = UUID()
    let name: String
    var subtopics: [SubTopic]
    var isSolved: Bool
    var state : TopicState
}

struct Lesson: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let color : Color
    var topics: [Topic]
}


enum TopicState : String {
    case current = "Current"
    case isLocked = "isLocked"
    case isValidated = "isValidated"
}
