//
//  SelectFirstLessonView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

// In this view the user select among all lessons the once he's interested about

struct SelectFirstLessonView: View {
    
    let lessons = AppViewModel.shared.lessons
    @State private var isSelected : Bool = false
    @State private var selectedLessonIds : [UUID] = []
    
    var body: some View {
        VStack {
            
            Text("What would you like to learn?")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .bold()
                .padding()
            
            Spacer()
            // 10 lessons maximum for the stat.
            ScrollView {
                ForEach(lessons) { lesson in
                        LessonButton(lesson: lesson, isSelected: selectedLessonIds.contains(lesson.id), isProgressShown: false) {
                            if let index = selectedLessonIds.firstIndex(of: lesson.id) {
                                selectedLessonIds.remove(at: index)
                            } else {
                                selectedLessonIds.append(lesson.id)
                            }
                    }
                    .padding(.top,3)
                }
            }
            Spacer()
            
            ValidationButton(questionState: State() ) {
                //
            }
        }
    }
    
    func State() -> QuestionState {
        if selectedLessonIds.isEmpty {
            return .isNeutral
        } else {
            return .isValid
        }
    }
}

#Preview {
    SelectFirstLessonView()
}
