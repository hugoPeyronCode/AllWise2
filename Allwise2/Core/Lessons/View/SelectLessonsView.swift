//
//  LessonsView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 13/11/2023.
//

import SwiftUI

struct SelectLessonsView: View {
    
    @ObservedObject var vm = AppViewModel.shared
    
    var body: some View {
        ScrollView {
            // Updated grid to have two flexible columns
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                ForEach(vm.lessons, id: \.id) { lesson in
                    LessonButton(lesson: lesson)
                        .padding()
                }
            })
        }
    }
}


#Preview {
    SelectLessonsView()
}

struct LessonButton: View {
    
    let lesson: Lesson
    
    @State var isSelected : Bool = false
    
    var body: some View {
        VStack {
            Text(lesson.image)
            Text(lesson.name)
        }
        .font(.system(size: 40))
        .frame(width: 50, height: 60)
    }
}
