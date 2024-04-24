//
//  VideoPlayer.swift
//  Allwise2
//
//  Created by Hugo Peyron on 24/04/2024.
//

import SwiftUI
import AVKit
import SwiftUI
import AVKit

struct ReusableVideoPlayer: View {
    var fileName: String
    var fileType: String
    
    @State private var player: AVPlayer?

    var body: some View {
        VideoPlayer(player: player)
            .disabled(true)
            .onAppear {
                setupPlayer()
            }
            .onDisappear {
                player?.pause()
                player = nil // Release the player when view disappears
            }
            .edgesIgnoringSafeArea(.all)
    }
    
    private func setupPlayer() {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("Error: File not found.")
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.isMuted = true // Mute the audio
        player?.play()
        
        // Looping the video
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }
}

struct ReusableVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ReusableVideoPlayer(fileName: "rain1", fileType: "mp4")
            .ignoresSafeArea()
            .scaledToFill()
    }
}
