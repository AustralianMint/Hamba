//
//  MockAudioEngine.swift
//  Hamba
//
//  Created by Péter Sanyó on 07.05.24.
//

import AVFoundation
import SwiftUI
@testable import Hamba
import XCTest


// MARK: - Arrange

protocol AudioEngineProtocol {
    var isRunning: Bool { get }
    var mainMixerNode: AVAudioMixerNode { get }
    func setupAudioEngine()
    func playSound(file: AudioFiles)
    func fade(up: Bool, in fadeTime: Double)
    func pauseSound(in seconds: Double)
    func resumeSound(in seconds: Double)
    func pulsatingReverbEffect(in cycleTime: Double)
}

// MARK: -  Act

class MockAudioEngine: AudioEngineProtocol {
    var isRunning: Bool = false
    var mainMixerNode = AVAudioMixerNode()

    // Tracking state for assertions in tests
    var outputVolumeChanges: [(volume: Float, time: Double)] = []
    var lastPlayedFile: AudioFiles?
    var lastFadeDirectionUp: Bool?
    var lastFadeTime: Double?
    var lastPauseTime: Double?
    var lastResumeTime: Double?
    var isPulsatingReverbActive: Bool = false
    
    func setup() {
        // initial setup of each test
    }
    
    func tearDown() {
        // 
    }

    func setupAudioEngine() {
        simulateEngineSetup()
    }

    func playSound(file: AudioFiles) {
        simulateSoundPlaying(file: file)
    }

    func fade(up: Bool, in fadeTime: Double) {
        simulateFade(up: up, in: fadeTime)
    }

    func pauseSound(in seconds: Double) {
        simulatePausing(in: seconds)
    }

    func resumeSound(in seconds: Double) {
        simulateResuming(in: seconds)
    }

    func pulsatingReverbEffect(in cycleTime: Double) {
        simulateReverbEffect(in: cycleTime)
    }

    // MARK: - Mock behaviors

    private func simulateEngineSetup() {
        isRunning = true
        mainMixerNode.outputVolume = 0
    }

    private func simulateSoundPlaying(file: AudioFiles) {
        isRunning = true
        lastPlayedFile = file
    }

    private func simulateFade(up: Bool, in fadeTime: Double) {
        lastFadeDirectionUp = up
        lastFadeTime = fadeTime
        let finalVolume: Float = up ? 1.0 : 0.0
        outputVolumeChanges.append((finalVolume, fadeTime))
        mainMixerNode.outputVolume = finalVolume
    }

    private func simulatePausing(in seconds: Double) {
        lastPauseTime = seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.mainMixerNode.outputVolume = 0
            self.isRunning = false
        }
    }

    private func simulateResuming(in seconds: Double) {
        lastResumeTime = seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.mainMixerNode.outputVolume = 1
            self.isRunning = true
        }
    }

    private func simulateReverbEffect(in cycleTime: Double) {
        isPulsatingReverbActive = true
        // rest of function ...
    }
    
    // and so on ..
}


// MARK: - Assert

final class MockAudioEngineTests: XCTestCase {
    private var mockAudioEngine: AudioEngineProtocol!

    override func setUp() {
        super.setUp()
        mockAudioEngine = MockAudioEngine()
        mockAudioEngine.setupAudioEngine()
    }

    func testAudioEngineIsSetup() {
        XCTAssertTrue(mockAudioEngine.isRunning)
        XCTAssertEqual(mockAudioEngine.mainMixerNode.outputVolume, 0)
    }
    
    // ...
}
