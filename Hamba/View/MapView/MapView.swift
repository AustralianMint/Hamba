//
//  MapView.swift
//  Hamba
//
//  Created by Péter Sanyó on 15.02.24.
//

import AVFoundation
import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject var audioEngine: AudioEngine
    @StateObject var mapViewModel: MapViewModel
    @State private var soundIsActive: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                mainMap(mapViewModel: mapViewModel)
                    .ignoresSafeArea()
                navBar
                creditButton
                addSpotButton
            }
        }
        .phoneOnlyNavigationView()
        .onAppear(perform: {
            mapViewModel.checkIfLocationServicesIsEnabled()
            audioEngine.firstFadeIn(audioFile: audioEngine.selectedSong, fadeDuration: 7)
        })
    }
    
    private var creditButton: some View {
        VStack(alignment: .trailing) {
            Spacer()
            HStack {
                Spacer()
                creditScreen()
            }
        }
        .padding(.trailing)
    }

    private var addSpotButton: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                AddSpotScreen()
            }
        }
    }

    private var navBar: some View {
        VStack {
            mainNavBar(mapViewModel: mapViewModel, soundIsActive: $soundIsActive)
            HStack {
                Spacer()

                songPicker(selectedSong: $audioEngine.selectedSong, soundIsActive: $soundIsActive)
                    .padding(.trailing, 5)
            }
            Spacer()
        }
    }
}

#Preview {
    MapView(mapViewModel: MapViewModel())
        .environmentObject(AudioEngine())
}
