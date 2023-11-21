//
//  HomeView.swift
//  Allwise2
//
//  Created by Hugo Peyron on 21/11/2023.
//
import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm = AppViewModel.shared
    @ObservedObject var lifesManager = LifesManager.shared
    @ObservedObject var userManager = UserManager.shared
    
    @State private var navToUserDashboard : Bool = false
    @State private var navToSelectLessonView : Bool = false
    
    @State var selectedLessonID : UUID = AppViewModel.shared.lessons.first!.id
    
    var body: some View {
        NavigationStack {
            ZStack {
            
                if lifesManager.triggerModal {
                    Color.duoWhite.opacity(0.3)
                        .ignoresSafeArea()
                        .zIndex(2)
                    
                    BuyNewLifesOverlay(
                        
                        onContinueLearning: {
                        lifesManager.refillLifes(count: 3)
                        lifesManager.triggerModal = false
                            
                    }, onEndSession: {
                        lifesManager.triggerModal = false
                    })
                    .transition(.move(edge: .bottom))
                    .zIndex(3)
                }
                
                TopicsView(lesson: selectedLesson())
                
                BottomButtons
                
            }
            .onAppear{
                vm.makeFirstUnSolvedTopicStateToCurrent(lessonId: selectedLesson().id)
                print("Home View Appears")
            }
            .navigationDestination(isPresented: $navToUserDashboard) {
                UserDashboardView()
            }
            .navigationDestination(isPresented: $navToSelectLessonView) {
                SelectLessonsView(selectedLessonID: $selectedLessonID)
            }
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Text(selectedLesson().image)
                        Text("\(selectedLesson().name)")
                            .font(.system(.body, design: .rounded, weight: .black))
                            .foregroundStyle(selectedLesson().color)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    StreakCounterView
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    LifesCounterView
                }
            }
        }
    }
    
    
    func selectedLesson() -> Lesson {
        return vm.findLesson(by: selectedLessonID)
    }
    
    var StreakCounterView : some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundStyle(Gradient(colors: [.yellow, .orange, .red]))
            Text("\(userManager.bestDayStreakCount)")
                .font(.system(.body, design: .rounded, weight: .black))
                .foregroundStyle(.reverseWhite.opacity(0.4))
        }
        
    }
    
    var LifesCounterView : some View {
        HStack {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
            Text("\(lifesManager.lifesCount)")
                .font(.system(.body, design: .rounded, weight: .black))
                .foregroundStyle(.reverseWhite.opacity(0.4))
        }
        
    }
    
    var BottomButtons : some View {
        VStack {
            Spacer()
            HStack{
                
                SmallNavButton(icon: "book.fill", text: "Lessons", mainColor: .orange) {
                    navToSelectLessonView.toggle()
                }
                .padding(.horizontal)
                .padding(.top, 5)

                Spacer()
                
                SmallNavButton(icon: "person.fill", text: "Profil", mainColor: .duoGreen) {
                    navToUserDashboard.toggle()
                }
                .padding(.horizontal)
                .padding(.top, 5)

            }
        }
    }
}

#Preview {
    HomeView()
}
