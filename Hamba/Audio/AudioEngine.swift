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
    static let shared = AudioEngine() // Provides a global point of access to it -> only one instance referenced

    var audioPlayer: AVAudioPlayer?
    
    // MARK: - Engine
    
    /// Configures and activates the `AVAudioSession` to play audio.
    /// It sets the session category to playback with options to duck other audio sources.
    /// - Throws: An `Error` if setting the category or activating the session fails.
    func startEngine() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [.duckOthers] // silences othe sound sources when app is running 
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error occurred while trying to start the audio engine: \(error)")
        }
    }
    
    // MARK: - File handling
    
    /// Plays a sound from a specified file.
    /// This method attempts to locate the audio file in the app's main bundle, initializes an `AVAudioPlayer` with it, and starts playback.
    /// - Parameters:
    ///   - file: The name of the sound file to play.
    ///   - type: The file extension/type of the sound file.
    /// - Note: The audio will loop indefinitely until `stopSound` is called.
    /// - Throws: An `Error` if the audio file cannot be found, loaded, or played.
    private func playSound(file: String, type: String) {
        // safely accessing file to prevent possible crash if file is not found
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            print("Error: Could not find the audio file.")
            return
        }
            
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Error occurred while trying to play the sound: \(error)")
        }
    }
    
    /// Plays a sound from a specified file using type-safe audio file references.
    /// - Parameter audioFile: The `AudioFiles` enum case representing the sound file to play.
    func playSound(audioFile: AudioFiles) {
        playSound(file: audioFile.fileName, type: audioFile.fileType)
    }

    
    /// Stops the currently playing sound and deactivates the audio session.
    func stopSound() {
        audioPlayer?.stop()
    }
    
    }
