//
//  AudioPlayer.swift
//  Allwise2
//
//  Created by Hugo Peyron on 16/04/2024.
//

import Foundation
import AVFoundation


/// BACKGROUND SOUND

// Audio player variable
var audioPlayer: AVAudioPlayer?

// Function to start playing music
func startPlayingMusic() {
    let randomNumber = Int.random(in: 0...4) // Random number between 0 and 4
    let fileName = "chill_\(randomNumber)" // Construct file name using the random number
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = -1 // Loop indefinitely
        audioPlayer?.play()
    } catch let error {
        print("Error playing music: \(error.localizedDescription)")
    }
}

// Function to stop playing music
func stopPlayingMusic() {
    audioPlayer?.stop()
    audioPlayer = nil
}
