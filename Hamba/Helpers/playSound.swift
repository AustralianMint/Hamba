//
//  playSound.swift
//  Hamba
//
//  Created by Thomas Frey on 03.05.23.
//  This file creates a variable with the audio player.

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("HAALP! Could not find and load the audio file.")
        }
    }
}
