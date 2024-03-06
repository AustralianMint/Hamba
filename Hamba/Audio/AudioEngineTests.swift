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
    private lazy var testAudioEngine = AudioEngine()

    func testAudioEngineIsSetup() {
        testAudioEngine.setupAudioEngine()
        let volume = testAudioEngine.audioEngine.mainMixerNode.outputVolume

        XCTAssertFalse(testAudioEngine.audioPlayerNode.isPlaying)
        XCTAssertTrue(testAudioEngine.audioEngine.isRunning)
        XCTAssertEqual(volume, 0)
    }

    func testLinearFade() {
        let fadeTime: Double = 7
        let expectationMiddle = XCTestExpectation(description: "Middle of fade")
        let expectationEnd = XCTestExpectation(description: "End of fade")

        testAudioEngine.setupAudioEngine()
        testAudioEngine.fade(up: true, in: fadeTime)

        /// middle of fade
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime / 2) {
            let midVolume = self.testAudioEngine.audioEngine.mainMixerNode.outputVolume
            XCTAssertEqual(midVolume, 0.5, accuracy: 0.05)
            expectationMiddle.fulfill()
        }

        /// End of fade
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeTime) {
            let endVolume = self.testAudioEngine.audioEngine.mainMixerNode.outputVolume
            XCTAssertEqual(endVolume, 1, accuracy: 0.05)
            expectationEnd.fulfill()
        }

        wait(for: [expectationMiddle, expectationEnd], timeout: fadeTime + 1)
    }

    func testPlaySound() {
        testAudioEngine.setupAudioEngine()
        testAudioEngine.playSound(file: .focusLoopCorporateMusic)

        XCTAssertTrue(testAudioEngine.audioPlayerNode.isPlaying)
    }
    
    func testPauseSound() {
        testAudioEngine.setupAudioEngine()
        testAudioEngine.playSound(file: .focusLoopCorporateMusic)
        testAudioEngine.pauseSound(in: 1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.testAudioEngine.audioPlayerNode.volume, 0)
            XCTAssertFalse(self.testAudioEngine.audioPlayerNode.isPlaying)
        }
    }
    
    func testResumeSound() {
        testAudioEngine.setupAudioEngine()
        testAudioEngine.playSound(file: .focusLoopCorporateMusic)
        testAudioEngine.pauseSound(in: 1)
        testAudioEngine.resumeSound(in: 1)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.testAudioEngine.audioPlayerNode.volume, 1)
            XCTAssertTrue(self.testAudioEngine.audioPlayerNode.isPlaying)
        }
    }
    
    
    
}
