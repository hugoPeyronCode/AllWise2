//
//  SessionProgressBar.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//


import SwiftUI

struct SessionProgressBar: View {
    @ObservedObject var viewModel: SessionProgressBarViewModel
    
    let width = SizeConstants.mainProgressBarWidth
    let height = SizeConstants.mainProgressBarHeight
    
    @State private var sessionProgressBarOffset : CGFloat = 120
    @State private var isShowingTriggerButton = true
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
            ZStack(alignment: .center) {
                
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .opacity(0.9)
                    .blur(radius: 5, opaque: true)
                    .ignoresSafeArea()
                
                if isShowingTriggerButton {
                    TriggerButton
                }
                
                VStack {
                    
                    ZStack(alignment: .leading) {
                        
                        // Progress Rectangle
                        Rectangle()
                            .frame(width: width * viewModel.progressValue)
                            .foregroundStyle(.primary.opacity(0.5))
                            .opacity(0.5)

                        
                        // SF Symbols
                        HStack{
                            ForEach(viewModel.tasks.indices, id: \.self) { indice in
                                Image(systemName: viewModel.icons[indice])
                                    .foregroundStyle(viewModel.isTaskCompleted(index: indice) ? .white : .black)
                                    .font(.title)
                                    .frame(width: width / 5.3)
                            }
                        }
                    }
                }
                .offset(y: sessionProgressBarOffset)
                .ignoresSafeArea()
                
            }
            .onTapGesture {
                withAnimation {
                    sessionProgressBarOffset = 120
                    isShowingTriggerButton = true
            }            }
            .disabled(viewModel.progressValue >= 1.0)
            .offset(y: sessionProgressBarOffset)
    }
}

extension SessionProgressBar {
    var TriggerButton : some View {
        // Trigger Button
        Button {
            withAnimation {
                if sessionProgressBarOffset == 120 {
                    sessionProgressBarOffset = 0
                    isShowingTriggerButton = false
                }
            }
        } label: {
            Image(systemName: "chevron.up")
                .font(.largeTitle)
                .fontWeight(.black)
//            RoundedRectangle(cornerRadius: 150)
//                .frame(width: 100, height: 10)
        }
        .foregroundStyle(.thinMaterial)
        .offset(y: sessionProgressBarOffset * -1)
    }
}

#Preview {
    ZStack {
        ReusableVideoPlayer(fileName: .constant("rain1"), fileType: "mp4")
        SessionProgressBar(viewModel: SessionProgressBarViewModel())
    }
}
