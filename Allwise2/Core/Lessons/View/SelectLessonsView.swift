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
                        LessonButton(lesson: lesson, isSelected: selectedLessonID == lesson.id, isProgressShown: true) { selectedLessonID = lesson.id }
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
