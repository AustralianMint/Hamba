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

final class AudioEngineTests: XCTestCase {
    private lazy var mockAudioEngine = AudioEngine()

    func testAudioEngineIsSetup() {
        mockAudioEngine.setupAudioEngine()
        let volume = mockAudioEngine.audioEngine.mainMixerNode.outputVolume

        XCTAssertFalse(mockAudioEngine.audioPlayerNode.isPlaying)
        XCTAssertTrue(mockAudioEngine.audioEngine.isRunning)
        XCTAssertEqual(volume, 0)
    }

    func testLinearFade() {
        let fadeTime: Double = 7
        let expectationMiddle = XCTestExpectation(description: "Middle of fade")
        let expectationEnd = XCTestExpectation(description: "End of fade")

        mockAudioEngine.setupAudioEngine()
        mockAudioEngine.fade(up: true, in: fadeTime)

        /// middle of fade
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime / 2) {
            let midVolume = self.mockAudioEngine.audioEngine.mainMixerNode.outputVolume
            XCTAssertEqual(midVolume, 0.5, accuracy: 0.05)
            expectationMiddle.fulfill()
        }

        /// End of fade
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime) {
            let endVolume = self.mockAudioEngine.audioEngine.mainMixerNode.outputVolume
            XCTAssertEqual(endVolume, 1, accuracy: 0.05)
            expectationEnd.fulfill()
        }

        wait(for: [expectationMiddle, expectationEnd], timeout: fadeTime + 1)
    }

    func testPlaySound() {
        mockAudioEngine.setupAudioEngine()
        mockAudioEngine.playSound(file: .focusLoopCorporateMusic)

        XCTAssertTrue(mockAudioEngine.audioPlayerNode.isPlaying)
    }

    func testPauseSound() {
        mockAudioEngine.setupAudioEngine()
        mockAudioEngine.playSound(file: .focusLoopCorporateMusic)
        mockAudioEngine.pauseSound(in: 1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.mockAudioEngine.audioPlayerNode.volume, 0)
            XCTAssertFalse(self.mockAudioEngine.audioPlayerNode.isPlaying)
        }
    }

    func testResumeSound() {
        mockAudioEngine.setupAudioEngine()
        mockAudioEngine.playSound(file: .focusLoopCorporateMusic)
        mockAudioEngine.pauseSound(in: 1)
        mockAudioEngine.resumeSound(in: 1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.mockAudioEngine.audioPlayerNode.volume, 1)
            XCTAssertTrue(self.mockAudioEngine.audioPlayerNode.isPlaying)
        }
    }

    func testPulsatingReverbEffect() {
        let reverbTimer: Double = 10
        let shouldReverbPercentage: Float = 80
        let initialReverbPercentage = mockAudioEngine.reverbNode.wetDryMix

        let expectationMiddle = XCTestExpectation(description: "Middle of fade")
        let expectationEnd = XCTestExpectation(description: "End of fade")

        mockAudioEngine.setupAudioEngine()
        mockAudioEngine.firstFadeIn(audioFile: .focusLoopCorporateMusic, fadeDuration: 0.5)

        XCTAssertTrue(initialReverbPercentage == 0)

        mockAudioEngine.pulsatingReverbEffect(in: reverbTimer)

        DispatchQueue.main.asyncAfter(deadline: .now() + reverbTimer / 2) {
            let midReverbPercentage = self.mockAudioEngine.reverbNode.wetDryMix
            XCTAssertEqual(midReverbPercentage, shouldReverbPercentage / 2, accuracy: 5)
            expectationMiddle.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + reverbTimer) {
            let maxReverbPercentage = self.mockAudioEngine.reverbNode.wetDryMix
            XCTAssertEqual(maxReverbPercentage, shouldReverbPercentage, accuracy: 5)
            expectationEnd.fulfill()
        }
        wait(for: [expectationMiddle, expectationEnd], timeout: reverbTimer + 1)
    }
}
