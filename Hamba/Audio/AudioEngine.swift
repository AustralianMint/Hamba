//
//  AudioEngine.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.

import AVFoundation
import SwiftUI

/// A singleton class that encapsulates all audio-related logic within the application.
/// It manages audio playback, including starting and stopping the engine, playing sounds with specified files,
/// handling audio session activation, and applying fade-in and fade-out effects.
public class AudioEngine: ObservableObject {
    static let shared = AudioEngine() // Provides a singleton instance for global access throughout the application

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
    /// It starts to play the sound at Volume 0 to adjust that with the fade-functions
    /// This method attempts to locate the audio file in the app's main bundle, initializes an `AVAudioPlayer` with it, and starts playback.
    /// - Parameters:
    ///   - file: The name of the sound file to play.
    ///   - type: The file extension/type of the sound file.
    /// - Note: The audio will loop indefinitely until `stopSound` is called.
    private func playSound(file: String, type: String) {
        // safely accessing file to prevent possible crash if file is not found
        guard let path = Bundle.main.path(forResource: file, ofType: type) else {
            print("Error: Could not find the audio file.")
            return
        }
            
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.volume = 0 // Start with volume at 0
            audioPlayer?.play()
        } catch {
            print("Error occurred while trying to play the sound: \(error)")
        }
    }
    
    /// Plays a sound with a fade-in effect from a specified audio file.
    /// The sound playback begins at volume 0 and gradually increases to volume 1 over the specified duration.
    /// - Parameters:
    ///   - audioFile: The `AudioFiles` enum case representing the sound file to play.
    ///   - fadeDuration: The duration over which the volume should fade in to 1.
    /// This method assumes that an `AVAudioPlayer` instance is already initialized.
    func firstFadeIn(audioFile: AudioFiles, fadeDuration: Float ) {
        playSound(file: audioFile.fileName, type: audioFile.fileType)
        audioPlayer?.setVolume(1, fadeDuration: TimeInterval(fadeDuration))
    }
    
    /// Fades to Volume:0 and then stops the currently playing sound
    func pauseSoundIn(seconds: TimeInterval) {
        audioPlayer?.setVolume(0, fadeDuration: seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.audioPlayer?.pause()
        }
    }
    
    /// starts to play the sound and fades to Volume:1 afterwards
    func resumeSoundIn(seconds: TimeInterval) {
        self.audioPlayer?.play()
        audioPlayer?.setVolume(1, fadeDuration: seconds)
    }
    
    
}
