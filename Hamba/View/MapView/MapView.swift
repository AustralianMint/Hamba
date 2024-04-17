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

    var body: some View {
        NavigationView {
            ZStack {
                mainMap(mapViewModel: mapViewModel)
                    .ignoresSafeArea()
                navBar
            }
        }
        .phoneOnlyNavigationView()
        .onAppear(perform: {
            mapViewModel.checkIfLocationServicesIsEnabled()
            audioEngine.firstFadeIn(audioFile: audioEngine.selectedSong, fadeDuration: 7)
        })
    }

    private var navBar: some View {
            VStack {
                mainNavBar(mapViewModel: mapViewModel)
                HStack {
                    Spacer()
                    musicPicker
                        .padding(.trailing, 5)
                }
                Spacer()
            }
    }
    
    private var musicPicker: some View {
            songPicker(selectedSong: $audioEngine.selectedSong)
        }
}

#Preview {
    MapView(mapViewModel: MapViewModel())
        .environmentObject(AudioEngine())
}
