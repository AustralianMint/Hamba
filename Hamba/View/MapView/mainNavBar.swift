//
//  mainNavBar.swift
//  Hamba
//
//  Created by Thomas Frey on 16.06.23.
//

import _MapKit_SwiftUI
import AVFoundation
import SwiftUI

/// A navigation bar view for the `Hamba` app that includes branding and controls for map style and audio playback.
/// It utilizes an `EnvironmentObject` of `AudioEngine` for audio control and an `ObservedObject` of `MapViewModel` for managing map-related data and actions.
struct mainNavBar: View {
    @EnvironmentObject var audioEngine: AudioEngine
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var mapViewModel: MapViewModel
    @State private var isImageryMapType: Bool = false
    @State private var soundIsOn: Bool = true

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
    }
    
    var hambaImage: some View {
        Image(systemName: "figure.walk")
            .imageScale(.large)
            .padding(.leading, -15)
    }
    
    var buttonCollection: some View {
        HStack(alignment: .center) {
            filterButton
            Divider().padding(.vertical)
            musicButton
            Divider().padding(.vertical)
            mapStyleButton
        }
        .frame(maxHeight: 44)
        .buttonStyle(.plain)
    }
    
    var filterButton: some View {
        Button {
            audioEngine.pulsatingReverbEffect(in: 20)
        } label: {
            Image(systemName: audioEngine.isReverbEffectActive ? "dial.medium.fill" : "dial.medium")
        }
    }
    
    var musicButton: some View {
        Button {
            if soundIsOn {
                audioEngine.pauseSound(in: 1)
                self.soundIsOn = false
                print("soundIsOn = false")
            } else {
                audioEngine.resumeSound(in: 1)
                self.soundIsOn = true
                print("soundIsOn = true")
            }
        } label: {
            Image(systemName: soundIsOn ? "speaker.wave.3.fill" : "speaker.wave.3")
        }
    }
    
    var mapStyleButton: some View {
        Button {
            // 2. Toggle the map type on button press
            isImageryMapType.toggle()
            mapViewModel.mapType = isImageryMapType ? MapStyle.imagery : MapStyle.standard
        } label: {
            Image(systemName: isImageryMapType ? "square.2.layers.3d.top.filled" : "square.2.layers.3d.bottom.filled")
        }
    }
    
    /// Applies a background blur effect to the navigation bar.
    var blurredEdge: some View {
        VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
            .mask {
                LinearGradient(
                    stops: [
                        .init(color: Color.black.opacity(1), location: 0),
                        .init(color: Color.black.opacity(0.7), location: 0.9),
                        .init(color: Color.black.opacity(0), location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
            .offset(y: -3)
    }
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
        mainNavBar(mapViewModel: MapViewModel())
    }
}
