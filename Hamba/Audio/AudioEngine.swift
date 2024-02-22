//
//  AudioEngine.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.

import AVFoundation
import SwiftUI

/// A singleton class that encapsulates all audio-related logic within the application.
/// It manages audio playback, including starting and stopping the engine, playing sounds with specified files,
/// handling audio session activation, and applying fade-in and fade-outs or effects.
public class AudioEngine: ObservableObject {
    
    // TODO: test whether this makes sense
    static let shared = AudioEngine() // Provides a singleton instance

    var audioEngine: AVAudioEngine
    var audioPlayerNode: AVAudioPlayerNode
    var reverbNode: AVAudioUnitReverb
    
    @Published var isReverbActive: Bool = false
    var reverbTimer: Timer?

    init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        reverbNode = AVAudioUnitReverb()
        setupAudioEngine()
    }

    ///Sets up audio engine, with colume and effect set to 0
    func setupAudioEngine() {
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(reverbNode)

        reverbNode.loadFactoryPreset(.largeChamber)
        reverbNode.wetDryMix = 0

        let format = audioEngine.outputNode.inputFormat(forBus: 0)
        audioEngine.connect(audioPlayerNode, to: reverbNode, format: format)
        audioEngine.connect(reverbNode, to: audioEngine.mainMixerNode, format: format)
        audioEngine.mainMixerNode.outputVolume = 0

        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }

    func toggleReverb() {
        if isReverbActive {
            reverbNode.wetDryMix = 0
            reverbTimer?.invalidate()
            isReverbActive = false
        } else {
            let pulsationPeriod = 20.0 // pulsating cycle
            var isIncreasing = true

            reverbTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                let increment = Float(80.0 / (pulsationPeriod * 10.0))
                self.reverbNode.wetDryMix += isIncreasing ? increment : -increment

                // Reverse the direction of the pulsation at the limits
                if self.reverbNode.wetDryMix >= 80 || self.reverbNode.wetDryMix <= 0 {
                    isIncreasing.toggle()
                }
            }
            isReverbActive = true
        }
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
        if !audioEngine.isRunning {
            do {
                try audioEngine.start()
            } catch {
                print("Error starting audio engine: \(error)")
                return
            }
        }
        
        guard let url = Bundle.main.url(forResource: audioFile.fileName, withExtension: audioFile.fileType) else {
            print("Error: Could not find the audio file.")
            return
        }

        let audioFile = try! AVAudioFile(forReading: url)
        audioPlayerNode.scheduleFile(audioFile, at: nil)
        audioPlayerNode.play()
        audioEngine.mainMixerNode.outputVolume = 0

        // TODO: custom fade -> Substract
        let startVolume: Float = 0.0
        let endVolume: Float = 1.0
        let stepInterval: TimeInterval = 0.05
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
                self.audioEngine.mainMixerNode.outputVolume = endVolume
                timer.invalidate()
            }
        }
    }

    func pauseSound() {
        let startVolume: Float = 1.0
        let endVolume: Float = 0.0
        let stepInterval: TimeInterval = 0.05
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
                self.audioEngine.mainMixerNode.outputVolume = endVolume
                timer.invalidate()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.audioPlayerNode.pause()
        }
    }

    // Function to resume audio playback with a specified fade-in duration.
    func resumeSound() {
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
