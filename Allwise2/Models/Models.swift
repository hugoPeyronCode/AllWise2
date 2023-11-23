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

struct Question: Identifiable {
    let id = UUID()
    let question: String
    let image: String
    let explanation: String
    let answers: [Answer]
    var isSolved: Bool
}

struct SubTopic: Identifiable {
    let id = UUID()
    let name: String
    var questions: [Question]
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
