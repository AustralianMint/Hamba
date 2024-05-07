//
//  AudioEngineTests.swift
//  HambaTests
//
//  Created by Péter Sanyó on 06.03.24.
//

import AVFoundation
@testable import Hamba
import SwiftUI
import XCTest

class AudioEngineTests: XCTestCase {
    /// Integration <-> Unit Test ?
    private lazy var mockAudioEngine = AudioEngine()
    
    /// framework automation
    override func setUp() {
        super.setUp()
        mockAudioEngine = AudioEngine()
        mockAudioEngine.setupAudioEngine()
    }

    override func tearDown() {
        super.tearDown()
        
        mockAudioEngine.audioPlayerNode.stop()
        
        if mockAudioEngine.audioEngine.isRunning {
            mockAudioEngine.audioEngine.stop()
        }
        
        if let timer = mockAudioEngine.reverbTimer {
            timer.invalidate()
            mockAudioEngine.reverbTimer = nil
        }
        
        mockAudioEngine.reverbNode.wetDryMix = 0
        mockAudioEngine.audioEngine.mainMixerNode.outputVolume = 0
    }
    
    /// testing state of setup
    func testAudioEngineSetup() {
        XCTAssertTrue(mockAudioEngine.audioEngine.isRunning, "Audio engine should be running after setup")
    }

    func testMixerVolumeSetup() {
        XCTAssertEqual(mockAudioEngine.audioEngine.mainMixerNode.outputVolume, 0, "Initial main mixer volume should be 0")
    }

    func testReverbNodeSetup() {
        XCTAssertEqual(mockAudioEngine.reverbNode.wetDryMix, 0, "Reverb node wet/dry mix should be initialized to 0")
    }

    func testPlaySound() {
        mockAudioEngine.playSound(file: .focusLoopCorporateMusic)
        XCTAssertTrue(mockAudioEngine.audioPlayerNode.isPlaying)
    }

    func testPauseSound() {
        let fadeTime: Double = 1
        mockAudioEngine.pauseSound(in: fadeTime)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime) {
            XCTAssertEqual(self.mockAudioEngine.audioPlayerNode.volume, 0)
            XCTAssertFalse(self.mockAudioEngine.audioPlayerNode.isPlaying)
        }
    }

    func testResumeSound() {
        mockAudioEngine.playSound(file: .focusLoopCorporateMusic)
        mockAudioEngine.pauseSound(in: 1)
        mockAudioEngine.resumeSound(in: 1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.mockAudioEngine.audioPlayerNode.volume, 1)
            XCTAssertTrue(self.mockAudioEngine.audioPlayerNode.isPlaying)
        }
    }
    
    func testLinearFade() {
        let fadeTime: Double = 7
        let expectationMiddle = XCTestExpectation(description: "Middle of fade")
        let expectationEnd = XCTestExpectation(description: "End of fade")
        
        mockAudioEngine.fade(up: true, in: fadeTime)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime / 2) {
            let midVolume = self.mockAudioEngine.audioEngine.mainMixerNode.outputVolume
            XCTAssertEqual(midVolume, 0.5, accuracy: 0.05)
            expectationMiddle.fulfill()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime) {
            let endVolume = self.mockAudioEngine.audioEngine.mainMixerNode.outputVolume
            XCTAssertEqual(endVolume, 1, accuracy: 0.05)
            expectationEnd.fulfill()
        }
        
        wait(for: [expectationMiddle, expectationEnd], timeout: fadeTime + 1)
    }
}

extension AudioEngineTests {
    /// Behavioral(Asynchronous) Test example
    func testPulsatingReverbEffect() {
        let reverbTimer: Double = 10
        let shouldReverbPercentage: Float = 80
        
        /// allows asynchronous operations to complete before assertions are verified
        let expectationStart = XCTestExpectation(description: "Start of effect")
        let expectationMiddle = XCTestExpectation(description: "Middle of effect")
        let expectationEnd = XCTestExpectation(description: "End of effect")

        XCTAssertEqual(mockAudioEngine.reverbNode.wetDryMix, 0, "Initial reverb should be 0")
        expectationStart.fulfill()

        mockAudioEngine.firstFadeIn(audioFile: .focusLoopCorporateMusic, fadeDuration: 0.5)
        mockAudioEngine.pulsatingReverbEffect(in: reverbTimer)

        DispatchQueue.main.asyncAfter(deadline: .now() + (reverbTimer / 2)) {
            let midReverbPercentage = self.mockAudioEngine.reverbNode.wetDryMix
            XCTAssertEqual(midReverbPercentage, shouldReverbPercentage / 2, accuracy: 5)
            expectationMiddle.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + reverbTimer) {
            let maxReverbPercentage = self.mockAudioEngine.reverbNode.wetDryMix
            XCTAssertEqual(maxReverbPercentage, shouldReverbPercentage, accuracy: 5)
            expectationEnd.fulfill()
        }
        /// blocks the test's execution until all expectations passed
        wait(for: [expectationStart, expectationMiddle, expectationEnd], timeout: reverbTimer + 1)
    }
}
