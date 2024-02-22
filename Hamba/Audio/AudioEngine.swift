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

    // Use AVAudioEngine for more complex audio processing including effects
    var audioEngine: AVAudioEngine
    var audioPlayerNode: AVAudioPlayerNode
    var reverbNode: AVAudioUnitReverb
    
    var isReverbActive: Bool = false
    var reverbTimer: Timer?

    init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        reverbNode = AVAudioUnitReverb()
        setupAudioEngine()
    }

    func setupAudioEngine() {
        // Attach nodes
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(reverbNode)

        // Set up reverb with default settings
        reverbNode.loadFactoryPreset(.largeChamber)
        reverbNode.wetDryMix = 0 // Start with reverb effect turned off

        // Connect nodes
        let format = audioEngine.outputNode.inputFormat(forBus: 0)
        audioEngine.connect(audioPlayerNode, to: reverbNode, format: format)
        audioEngine.connect(reverbNode, to: audioEngine.mainMixerNode, format: format)
        audioEngine.mainMixerNode.outputVolume = 0

        // Start the engine
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }

    func toggleReverb() {
        if isReverbActive {
            // If reverb is active, turn it off by setting wetDryMix to 0
            reverbNode.wetDryMix = 0
            reverbTimer?.invalidate() // Stop the pulsation timer
        } else {
            // If reverb is inactive, start the pulsation effect
            let pulsationPeriod = 20.0 // 20 seconds for a full pulsation cycle
            var isIncreasing = true

            reverbTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self else { return }

                let increment = Float(80.0 / (pulsationPeriod * 10.0)) // Adjust this to change the speed of pulsation
                self.reverbNode.wetDryMix += isIncreasing ? increment : -increment

                // Reverse the direction of the pulsation at the limits
                if self.reverbNode.wetDryMix >= 80 || self.reverbNode.wetDryMix <= 0 {
                    isIncreasing.toggle()
                }
            }
        }
        // Toggle the reverb state
        isReverbActive.toggle()
    }

    func startEngine() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback,
                mode: AVAudioSession.Mode.default,
                options: [.duckOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error occurred while trying to start the audio engine: \(error)")
        }
    }

    private func playSound(file: String, type: String) {
        guard let url = Bundle.main.url(forResource: file, withExtension: type) else {
            print("Error: Could not find the audio file.")
            return
        }

        let audioFile = try! AVAudioFile(forReading: url)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        if !audioEngine.isRunning {
            try! audioEngine.start()
        }
        audioPlayerNode.play()
    }

    func firstFadeIn(audioFile: AudioFiles, fadeDuration: TimeInterval) {
        // Ensure the audio engine is running.
        if !audioEngine.isRunning {
            do {
                try audioEngine.start()
            } catch {
                print("Error starting audio engine: \(error)")
                return
            }
        }

        // Schedule the audio file for playback.
        guard let url = Bundle.main.url(forResource: audioFile.fileName, withExtension: audioFile.fileType) else {
            print("Error: Could not find the audio file.")
            return
        }

        let audioFile = try! AVAudioFile(forReading: url)
        audioPlayerNode.scheduleFile(audioFile, at: nil) {
            // Completion handler code if needed.
        }

        // Start playback.
        audioPlayerNode.play()

        // Reset the mixer node's output volume to 0 before starting the fade-in effect.
        audioEngine.mainMixerNode.outputVolume = 0

        // Initial conditions for fade-in
        let startVolume: Float = 0.0
        let endVolume: Float = 1.0
        let stepInterval: TimeInterval = 0.05 // Time interval between volume updates
        let totalSteps = Int(fadeDuration / stepInterval)
        let volumeStep = (endVolume - startVolume) / Float(totalSteps)

        var currentStep = 0
        Timer.scheduledTimer(withTimeInterval: stepInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if currentStep < totalSteps {
                let currentVolume = startVolume + volumeStep * Float(currentStep)
                self.audioEngine.mainMixerNode.outputVolume = currentVolume
                currentStep += 1
            } else {
                // Ensure the volume is set to the final value in case of rounding issues
                self.audioEngine.mainMixerNode.outputVolume = endVolume
                timer.invalidate()
            }
        }
    }

    func pauseSound() {
        // Initial conditions for fade-in
        let startVolume: Float = 1.0
        let endVolume: Float = 0.0
        let stepInterval: TimeInterval = 0.05 // Time interval between volume updates
        let totalSteps = Int(1 / stepInterval)
        let volumeStep = (endVolume - startVolume) / Float(totalSteps)
        var currentStep = 0

        Timer.scheduledTimer(withTimeInterval: stepInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if currentStep < totalSteps {
                let currentVolume = startVolume + volumeStep * Float(currentStep)
                self.audioEngine.mainMixerNode.outputVolume = currentVolume
                currentStep += 1
            } else {
                // Ensure the volume is set to the final value in case of rounding issues
                self.audioEngine.mainMixerNode.outputVolume = endVolume
                timer.invalidate()
            }
        }

        // After fading out, pause the player.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.audioPlayerNode.pause()
        }
    }

    // Function to resume audio playback with a specified fade-in duration.
    func resumeSound() {
        // Initial conditions for fade-in
        let startVolume: Float = 0.0
        let endVolume: Float = 1.0
        let stepInterval: TimeInterval = 0.05 // Time interval between volume updates
        let totalSteps = Int(1 / stepInterval)
        let volumeStep = (endVolume - startVolume) / Float(totalSteps)
        var currentStep = 0
        
        self.audioPlayerNode.play()
        
        Timer.scheduledTimer(withTimeInterval: stepInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }

            if currentStep < totalSteps {
                let currentVolume = startVolume + volumeStep * Float(currentStep)
                self.audioEngine.mainMixerNode.outputVolume = currentVolume
                currentStep += 1
            } else {
                // Ensure the volume is set to the final value in case of rounding issues
                self.audioEngine.mainMixerNode.outputVolume = endVolume
                timer.invalidate()
            }
        }
    }
}
