//
//  MockData.swift
//  Allwise2
//
//  Created by Hugo Peyron on 10/11/2023.
//

import Foundation

let mockData = [
    Lesson(name: "History", image: "🏺", color: .blue, topics: (1...10).map { topicIndex in
        Topic(name: "L1 T\(topicIndex)", subtopics: (1...2).map { subTopicIndex in
            SubTopic(
                name: "L1 T\(topicIndex) ST\(subTopicIndex)",
                questions: (1...3).map { questionIndex in
                    Question(
                        question: "L1 T\(topicIndex) ST\(subTopicIndex) Q\(questionIndex)", image: "",
                        explanation: "Explanation for L1 T\(topicIndex) ST\(subTopicIndex) Q\(questionIndex)",
                        answers: [
                            Answer(text: "Answer A", isTrue: true),
                            Answer(text: "Answer B", isTrue: false),
                            Answer(text: "Answer C", isTrue: false),
                            Answer(text: "Answer D", isTrue: false)
                        ],
                        isSolved: false,
                        type: .qcm // Using the .choice type as an example
                    )
                },
                isSolved: false
            )
        }, isSolved: false, state: .current)
    }),
    Lesson(name: "Geography", image: "🗺️", color: .teal, topics: (1...10).map { topicIndex in
        Topic(name: "L2 T\(topicIndex)", subtopics: (1...5).map { subTopicIndex in
            SubTopic(
                name: "L2 T\(topicIndex) ST\(subTopicIndex)",
                questions: (1...3).map { questionIndex in
                    Question(
                        question: "L2 T\(topicIndex) ST\(subTopicIndex) Q\(questionIndex)", image: "",
                        explanation: "Explanation for L2 T\(topicIndex) ST\(subTopicIndex) Q\(questionIndex)",
                        answers: [
                            Answer(text: "Answer A", isTrue: true),
                            Answer(text: "Answer B", isTrue: false),
                            Answer(text: "Answer C", isTrue: false),
                            Answer(text: "Answer D", isTrue: false)
                        ],
                        isSolved: false,
                        type: .qcm
                    )
                },
                isSolved: false
            )
        }, isSolved: false, state: .current)
    }),
    Lesson(name: "Science", image: "🧬", color: .mint, topics: (1...10).map { topicIndex in
        Topic(name: "L3 T\(topicIndex)", subtopics: (1...5).map { subTopicIndex in
            SubTopic(
                name: "L3 T\(topicIndex) ST\(subTopicIndex)",
                questions: (1...3).map { questionIndex in
                    Question(
                        question: "L3 T\(topicIndex) ST\(subTopicIndex) Q\(questionIndex)", image: "",
                        explanation: "Explanation for L3 T\(topicIndex) ST\(subTopicIndex) Q\(questionIndex)",
                        answers: [
                            Answer(text: "Answer A", isTrue: true),
                            Answer(text: "Answer B", isTrue: false),
                            Answer(text: "Answer C", isTrue: false),
                            Answer(text: "Answer D", isTrue: false)
                        ],
                        isSolved: false,
                        type: .qcm
                    )
                },
                isSolved: false
            )
        }, isSolved: false, state: .current)
    })
]
