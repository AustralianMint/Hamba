//
//  AudioEngine.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.
/// `AudioEngine` is a class designed to encapsulate the functionality for audio related logic..
/// It provides methods to start and stop the audio engine, play sounds from specified files, and handle audio session activation and deactivation.
/// - Note: It's important to manage the lifecycle of the `AudioEngine` instance properly to ensure that the audio session is deactivated when not needed.
///

import AVFoundation
import SwiftUI

public class AudioEngine: ObservableObject {
    // Provides a global point of access to it -> only one instance referenced 
    static let shared = AudioEngine()
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                //Create System-wide AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(
                    AVAudioSession.Category.playback,
                    mode: AVAudioSession.Mode.default,
                    options: [
                        AVAudioSession.CategoryOptions.duckOthers
                    ]
                )
                
                //Activate the session
                try! AVAudioSession.sharedInstance().setActive(true)
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("HAALP! Could not find and load the audio file.")
            }
        }
    }
}
