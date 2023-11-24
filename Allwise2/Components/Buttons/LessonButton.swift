//
//  LessonButton.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/11/2023.
//

import SwiftUI

struct LessonButton: View {
    
    let lesson: Lesson
    var isSelected: Bool
    var isProgressShown : Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Text(lesson.image)
                    .font(.title3)
                Text(lesson.name)
                    .font(.title3)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(isSelected ? .primary : .secondary)
                Spacer()
                
                if isProgressShown {
                    CircularProgressView(progress: AppViewModel.shared.progressOfLesson(lessonId: lesson.id), color: .darkGreen, fontSize: .caption2, lineWidth: 5, withText: true)
                        .frame(height: 50)
                        .opacity(isSelected ? 1 : 0.5)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(isSelected ? .duoBlue.opacity(0.1) : .clear)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? .darkBlue : .paleGray, lineWidth: 3)
            )
        .padding(.horizontal)
        }
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    LessonButton(lesson: Lesson(name: "Test", image: "🎅", color: .black, topics: []), isSelected: false, isProgressShown: true) {}
}
