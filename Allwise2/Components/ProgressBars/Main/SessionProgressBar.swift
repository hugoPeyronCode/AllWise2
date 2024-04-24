//
//  SessionProgressBar.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI

struct SessionProgressBar: View {
    @ObservedObject var viewModel: ProgressBarViewModel

    let width = SizeConstants.mainProgressBarWidth
    let height = SizeConstants.mainProgressBarHeight
        
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundStyle(.ultraThinMaterial)
                
                Rectangle()
                    .frame(width: width * viewModel.progressValue, height: height)
                    .foregroundStyle(.primary.opacity(0.5))
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
                .fill(.ultraThinMaterial)
                .frame(maxWidth: .infinity , maxHeight: SizeConstants.screenHeight)
                .ignoresSafeArea()
                .overlay {
                    Button("Continue") {
                        viewModel.incrementProgress()
                    }
                    .foregroundColor(.white)
                    .bold()
                }
                .onTapGesture {
                    viewModel.incrementProgress()
                }
        }
    }
}

#Preview {
        ZStack {
            ReusableVideoPlayer(fileName: "rain1", fileType: "mp4")
            SessionProgressBar(viewModel: ProgressBarViewModel())
        }
}
