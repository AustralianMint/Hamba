//
//  mainNavBar.swift
//  Hamba
//
//  Created by Thomas Frey on 16.06.23.
//

import _MapKit_SwiftUI
import AVFoundation
import SwiftUI
import FirebaseAuth

/// A navigation bar view for the `Hamba` app that includes branding and controls for map style and audio playback.
struct mainNavBar: View {
    @EnvironmentObject var audioEngine: AudioEngine
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var mapViewModel: MapViewModel
    @State private var isImageryMapType: Bool = false
    @Binding var soundIsActive: Bool


    var body: some View {
        HStack {
            hambaFont
            hambaImage
            Spacer()
            buttonCollection
        }
        .padding(.horizontal)
        .padding(.vertical, 0)
        .background(blurredEdge)
    }
    
    var hambaFont: some View {
        Text("Hamba")
            .padding()
            .font(.system(.title, design: .serif))
            .accessibilityLabel(accessibilityIntro)
    }
    
    var hambaImage: some View {
        Image(systemName: "figure.walk")
            .imageScale(.large)
            .padding(.leading, -15)
            .accessibilityHidden(true)
    }
    
    var buttonCollection: some View {
        HStack(alignment: .center, spacing: 0) {
            filterButton
            Divider().padding(.vertical, 5)

            musicButton
            Divider().padding(.vertical, 5)

            mapStyleButton
            Divider().padding(.vertical, 5)

            signOutButton
        }
        .frame(maxHeight: 45)
        .buttonStyle(.plain)
    }
    
    var filterButton: some View {
        Button {
            audioEngine.pulsatingReverbEffect(in: 20, intensity: 55)
        } label: {
            filterIcon(isActive: audioEngine.isReverbEffectActive)
        }
        .accessibilityLabel("toggle this button to add an effect to the played audio")
    }

    var signOutButton: some View {
        Button {
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        } label: {
            SignOutIcon()
        }
    }


    var musicButton: some View {
        Button {
            if soundIsActive {
                audioEngine.pauseSound(in: 1)
                self.soundIsActive = false
                print("soundIsOn = false")
            } else {
                audioEngine.resumeSound(in: 1)
                self.soundIsActive = true
                print("soundIsOn = true")
            }
        } label: {
            musicIcon(soundIsActive: $soundIsActive)
        }
        .accessibilityLabel("toggle this button to play and stop playing music")
    }
    
    var mapStyleButton: some View {
        Button {
            // Toggle the map type on button press
            isImageryMapType.toggle()
            mapViewModel.mapType = isImageryMapType ? MapStyle.imagery : MapStyle.standard
        } label: {
            mapStyleIcon(isActive: isImageryMapType)
        }
        .accessibilityLabel("toggle this button to change the appearance of the map")
    }
    
    /// Applies a background blur effect to the navigation bar.
    var blurredEdge: some View {
        VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
            .mask {
                LinearGradient(
                    stops: [
                        .init(color: Color.black.opacity(1), location: 0),
                        .init(color: Color.black.opacity(1), location: 0.95),
                        .init(color: Color.black.opacity(0.1), location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
            .offset(y: -3)
    }
    
     var accessibilityIntro: String =
"""
You have opened the App Hamba.
It helps you find the best outdoor locations in Berlin.
This app works mainly by displaying labels on a map.
There are buttons to select and play audio, add effects and change the presentation of the map.
We are working on improving the accessibility of our App.
Thanks for your understanding, and God Bless.
Bless Jah!
"""
}

/// A helper view that wraps `UIVisualEffectView` for SwiftUI usage, enabling blur effects.
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

struct mainNavBar_Previews: PreviewProvider {
    static var previews: some View {
        @State var mockIsActive = true
        mainNavBar(mapViewModel: MapViewModel(), soundIsActive: $mockIsActive)
            .environmentObject(AudioEngine())
    }
}
