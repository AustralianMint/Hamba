//
//  AudioEngine.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.
import AVFoundation
import SwiftUI

///  Overview:
///  `AudioEngine` is a class designed to manage and control audio playback with effects in the Hamba application.
///  It leverages `AVFoundation` to establish an audio processing graph, which includes playback nodes and effects nodes such as reverb.
///  A singleton pattern is implemented to ensure global access through a shared instance.
///
///  Properties:
///  - `shared`: A singleton instance of `AudioEngine` for global access.
///  - `audioEngine`: An instance of `AVAudioEngine` that manages the audio signal processing graph.
///  - `audioPlayerNode`: An `AVAudioPlayerNode` used for audio file playback.
///  - `reverbNode`: An `AVAudioUnitReverb` applied to add reverb effects to the audio output.
///
///  Initialization:
///  - `init()`: Initializes the audio engine and configures its components.
///
///  Methods:
///  - `setupAudioEngine()`: Configures the audio engine, attaching nodes and setting initial parameters.
///  - `startEngine()`: Sets up and activates the `AVAudioSession` for audio playback.
///  - `playSound(file:type:)`: Plays an audio file specified by its name and type.
///  - `firstFadeIn(audioFile:fadeDuration:)`: Initiates audio playback with a fade-in effect for the given audio file.
///  - `pauseSound()`: Pauses the currently playing audio with a fade-out effect.
///  - `resumeSound()`: Resumes audio playback that was paused, with a fade-in effect.
///
///  Reverb Control:
///  - `toggleReverb()`: Toggles the reverb effect on or off, applying a pulsation effect to the reverb intensity.
///
///  Note: The class uses published properties to enable SwiftUI views to react to changes in the audio playback state, including reverb activation.
public class AudioEngine: ObservableObject {
    static let shared = AudioEngine()

    var audioEngine: AVAudioEngine
    var audioPlayerNode: AVAudioPlayerNode
    var reverbNode: AVAudioUnitReverb

    init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        reverbNode = AVAudioUnitReverb()
        setupAudioEngine()
    }

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

    func resumeSound() {
        let startVolume: Float = 0.0
        let endVolume: Float = 1.0
        let stepInterval: TimeInterval = 0.05
        let totalSteps = Int(1 / stepInterval)
        let volumeStep = (endVolume - startVolume) / Float(totalSteps)
        var currentStep = 0

        audioPlayerNode.play()

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

    // MARK: - REVERB

    @Published var isReverbActive: Bool = false
    var reverbTimer: Timer?

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
}
