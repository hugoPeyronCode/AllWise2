//
//  LessonsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 13/11/2023.
//

import SwiftUI

struct SelectLessonsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm = AppViewModel.shared
    @Binding var selectedLessonID : UUID
    
    var body: some View {
        VStack {
            ScrollView {
            
                // Updated grid to have two flexible columns
                LazyVStack() {
                    ForEach(vm.lessons, id: \.id) { lesson in
                        LessonButton(lesson: lesson, isSelected: selectedLessonID == lesson.id) { selectedLessonID = lesson.id }
                    }
                }
                
            }
            ContinueButton(content: "Continue", backgroundColor: .duoBlue, shadowGroundColor: .darkBlue) {
                dismiss()
            }
            .navigationTitle("Courses")
            .navigationBarTitleDisplayMode(.inline)

        }
        .fontDesign(.rounded)
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    SelectLessonsView(selectedLessonID: .constant(UUID()))
}

struct LessonButton: View {
    
    let lesson: Lesson
    var isSelected: Bool
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
                
                CircularProgressView(progress: AppViewModel.shared.progressOfLesson(lessonId: lesson.id), color: .darkGreen, fontSize: .caption2, lineWidth: 5, withText: true)
                    .frame(height: 50)
                    .opacity(isSelected ? 1 : 0.5)
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
