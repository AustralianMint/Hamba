//
//  AudioEngine.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.
import AVFoundation
import SwiftUI

/// `AudioEngine` is a class designed to manage and manipulate audio playback with various effects within the Hamba application.
/// It employs `AVFoundation` to build and control an audio processing graph, facilitating the integration of audio functionality in SwiftUI views.
///
/// Properties:
///  - `audioEngine`: Manages the audio signal processing graph.
///  - `audioPlayerNode`: Plays audio files.
///  - `reverbNode`: Adds reverb effects to the audio.
///
/// Initialization:
///  - Initializes the audio components and configures the audio processing graph.
///
/// Methods:
///  - `playSound(file:)`: Plays a specified audio file.
///  - `firstFadeIn(audioFile:fadeDuration:)`: Begins playback with a fade-in effect.
///  - `pauseSound(in:)`: Pauses the audio with a fade-out effect.
///  - `resumeSound(in:)`: Resumes the audio with a fade-in effect.
///  - `pulsatingReverbEffect(in:intensity:)`: Toggles a pulsating reverb effect.
///  - `changeSong(to:fadeDuration:)`: Changes the currently playing song with a fade effect.
///  
class AudioEngine: ObservableObject {
    var audioEngine = AVAudioEngine()
    var audioPlayerNode = AVAudioPlayerNode()
    var reverbNode = AVAudioUnitReverb()

    @Published var isReverbEffectActive: Bool = false
    var reverbTimer: Timer?

    @Published var selectedSong: AudioFiles = .focusLoopCorporateMusic
    private var playbackSessionID: UUID?

    init() {
        setupAudioEngine()
    }

    // MARK: - Engine Launch

    func setupAudioEngine() {
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(reverbNode)
        reverbNode.loadFactoryPreset(.largeChamber)
        reverbNode.wetDryMix = 0
        let format = audioEngine.outputNode.inputFormat(forBus: 0)
        audioEngine.connect(audioPlayerNode, to: reverbNode, format: format)
        audioEngine.connect(reverbNode, to: audioEngine.mainMixerNode, format: format)
        audioEngine.mainMixerNode.outputVolume = 0
        startEngineIfNeeded()
    }

    private func startEngineIfNeeded() {
        guard !audioEngine.isRunning else { return }
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }

    // MARK: - (Loop) Playback

    func playSound(file: AudioFiles, shouldLoop: Bool) {
        guard let url = Bundle.main.url(forResource: file.rawValue, withExtension: file.fileType),
              let audioFile = try? AVAudioFile(forReading: url)
        else {
            return
        }

        let sessionID = UUID()
        playbackSessionID = sessionID
        audioPlayerNode.stop()
        scheduleAudioFile(audioFile, shouldLoop: shouldLoop, sessionID: sessionID)
    }

    private func scheduleAudioFile(_ audioFile: AVAudioFile, shouldLoop: Bool, sessionID: UUID) {
        DispatchQueue.main.async {
            self.audioPlayerNode.stop()
            self.audioPlayerNode.scheduleFile(audioFile, at: nil) {
                guard self.playbackSessionID == sessionID else { return }
                if shouldLoop {
                    self.scheduleAudioFile(audioFile, shouldLoop: shouldLoop, sessionID: sessionID)
                }
            }
            self.startEngineIfNeeded()
            self.audioPlayerNode.play()
        }
    }

    // MARK: - Custom Fade

    private func fade(up: Bool, in fadeTime: Double) {
        let startVolume: Float = up ? 0.0 : 1.0
        let endVolume: Float = up ? 1.0 : 0.0
        let stepInterval: TimeInterval = 0.05
        let totalSteps = Int(fadeTime / stepInterval)
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

    // MARK: - Start and Stop Playback

    func firstFadeIn(audioFile: AudioFiles, fadeDuration: TimeInterval) {
        playSound(file: audioFile, shouldLoop: true)
        fade(up: true, in: fadeDuration)
    }

    func pauseSound(in seconds: Double) {
        fade(up: false, in: seconds)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.audioPlayerNode.pause()
        }
    }

    func stopSong() {
        fade(up: false, in: 0)
        DispatchQueue.main.async {
            self.audioPlayerNode.stop()
            self.audioPlayerNode.reset()
        }
    }

    func resumeSound(in seconds: Double) {
        audioPlayerNode.play()
        fade(up: true, in: seconds)
    }

    // MARK: - Filter: REVERB

    func pulsatingReverbEffect(in cycleTime: Double, intensity: Float) {
        if isReverbEffectActive {
            reverbNode.wetDryMix = 0
            reverbTimer?.invalidate()
            isReverbEffectActive = false
        } else {
            var isIncreasing = true
            reverbTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self else { return }

                // Reverse the direction of the pulsation at the limits
                let increment = Float(80.0 / (cycleTime * 10.0))
                self.reverbNode.wetDryMix += isIncreasing ? increment : -increment
                if self.reverbNode.wetDryMix >= intensity || self.reverbNode.wetDryMix <= 0 {
                    isIncreasing.toggle()
                }
            }
            isReverbEffectActive = true
        }
    }

    // MARK: - Changing Songs

    func changeSong(to newSong: AudioFiles, fadeDuration: TimeInterval) {
        DispatchQueue.main.async {
            self.stopSong()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.audioPlayerNode.reset()
                self.playSound(file: newSong, shouldLoop: true)
                self.fade(up: true, in: fadeDuration)
            }
        }
    }
}
