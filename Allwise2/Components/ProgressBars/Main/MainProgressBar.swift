//
//  MainProgressBar.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct MainProgressBar: View {
    @ObservedObject var viewModel: ProgressBarViewModel

    let width = SizeConstants.mainProgressBarWidth
    let height = SizeConstants.mainProgressBarHeight
    
    @State var isShowingReset: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundStyle(.thinMaterial)
                
                Rectangle()
                    .frame(width: width * viewModel.progressValue, height: height)
                    .foregroundStyle(.primary)
                    .opacity(0.5)
//
                VStack {
                    HStack{
                        ForEach(viewModel.tasks.indices, id: \.self) { indice in
                            Image(systemName: viewModel.icons[indice])
                                .foregroundStyle(viewModel.isTaskCompleted(index: indice) ? .white : .gray)
                                .font(.title)
                                .frame(width: width / 5.5)
                        }
                    }
                }
            }
            .disabled(viewModel.progressValue >= 1.0)
            
            Rectangle()
                .fill(.thinMaterial)
                .frame(maxWidth: .infinity , maxHeight: SizeConstants.screenHeight)
                .ignoresSafeArea()
                .overlay {
                    Text("Continue")
                        .foregroundStyle(.gray)
                }
                .onTapGesture {
                    viewModel.incrementProgress()
                }
            if isShowingReset {
                Button {
                    viewModel.reset()
                } label: {
                    Text("reset")
                }
            }
        }
    }
}

#Preview {
    MainProgressBar(viewModel: ProgressBarViewModel(), isShowingReset: true)
}
