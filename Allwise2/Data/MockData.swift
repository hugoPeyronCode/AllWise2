//  MockData.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import Foundation
import SwiftUI

let mockData = [
    Lesson(name: "History", image: "🏺", color: .blue, topics: (1...10).map { topicIndex in
        Topic(name: "History Topic \(topicIndex)", subtopics: (1...2).map { subTopicIndex in
            SubTopic(
                name: "History SubTopic \(subTopicIndex)",
                questions: (1...5).flatMap { questionIndex -> [any Question] in
                    let matchingPairs = (1...5).map { pairIndex in
                        QuestionAnswerPair(
                            question: "History Pair \(pairIndex) Question \(questionIndex)",
                            answer: "History Pair \(pairIndex) Answer \(questionIndex)"
                        )
                    }
                    return [
                        QCMQuestion(
                            question: "History QCM Question \(questionIndex)",
                            image: "history_image_\(questionIndex)",
                            explanation: "Explanation for History QCM Question \(questionIndex)",
                            answers: [
                                Answer(text: "Answer A", isTrue: true),
                                Answer(text: "Answer B", isTrue: false),
                                Answer(text: "Answer C", isTrue: false),
                                Answer(text: "Answer D", isTrue: false)
                            ],
                            isSolved: false
                        ),
                        MatchingQuestion(
                            questions: matchingPairs,
                            isSolved: false
                        )
                    ]
                },
                isSolved: false
            )
        }, isSolved: false, state: .current)
    }),
    Lesson(name: "Geography", image: "🗺️", color: .teal, topics: (1...10).map { topicIndex in
        Topic(name: "Geography Topic \(topicIndex)", subtopics: (1...5).map { subTopicIndex in
            SubTopic(
                name: "Geography SubTopic \(subTopicIndex)",
                questions: (1...5).flatMap { questionIndex -> [any Question] in
                    let matchingPairs = (1...5).map { pairIndex in
                        QuestionAnswerPair(
                            question: "Geography Pair \(pairIndex) Question \(questionIndex)",
                            answer: "Geography Pair \(pairIndex) Answer \(questionIndex)"
                        )
                    }
                    return [
                        QCMQuestion(
                            question: "Geography QCM Question \(questionIndex)",
                            image: "geography_image_\(questionIndex)",
                            explanation: "Explanation for Geography QCM Question \(questionIndex)",
                            answers: [
                                Answer(text: "Answer A", isTrue: true),
                                Answer(text: "Answer B", isTrue: false),
                                Answer(text: "Answer C", isTrue: false),
                                Answer(text: "Answer D", isTrue: false)
                            ],
                            isSolved: false
                        ),
                        MatchingQuestion(
                            questions: matchingPairs,
                            isSolved: false
                        )
                    ]
                },
                isSolved: false
            )
        }, isSolved: false, state: .current)
    }),
    Lesson(name: "Science", image: "🧬", color: .mint, topics: (1...10).map { topicIndex in
        Topic(name: "Science Topic \(topicIndex)", subtopics: (1...5).map { subTopicIndex in
            SubTopic(
                name: "Science SubTopic \(subTopicIndex)",
                questions: (1...5).flatMap { questionIndex -> [any Question] in
                    let matchingPairs = (1...5).map { pairIndex in
                        QuestionAnswerPair(
                            question: "Science Pair \(pairIndex) Question \(questionIndex)",
                            answer: "Science Pair \(pairIndex) Answer \(questionIndex)"
                        )
                    }
                    return [
                        QCMQuestion(
                            question: "Science QCM Question \(questionIndex)",
                            image: "science_image_\(questionIndex)",
                            explanation: "Explanation for Science QCM Question \(questionIndex)",
                            answers: [
                                Answer(text: "Answer A", isTrue: true),
                                Answer(text: "Answer B", isTrue: false),
                                Answer(text: "Answer C", isTrue: false),
                                Answer(text: "Answer D", isTrue: false)
                            ],
                            isSolved: false
                        ),
                        MatchingQuestion(
                            questions: matchingPairs,
                            isSolved: false
                        )
                    ]
                },
                isSolved: false
            )
        }, isSolved: false, state: .current)
    })
]
