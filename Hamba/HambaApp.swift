//
//  HambaApp.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//
/// The root of the Hamba application.
///
/// `HambaApp` sets up the main scene of the app and injects the `AudioEngine` instance into the SwiftUI environment.
/// This setup ensures that the `AudioEngine` can be accessed from anywhere within the app, for easy audio management.
///
import SwiftUI

@main
struct HambaApp: App {
    var audioEngine = AudioEngine()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(audioEngine) // The `audioEngine` is injected into the environment of `SplashView`, making it accessible to `SplashView` and any of its child views.
        }
    }
}
