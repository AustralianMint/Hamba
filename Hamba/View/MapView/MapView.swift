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
            audioEngine.firstFadeIn(audioFile: .hambaVibes, fadeDuration: 7)
        })
    }

    var navBar: some View {
        VStack {
            mainNavBar(mapViewModel: mapViewModel)
            Spacer()
        }
    }
}

#Preview {
    MapView(mapViewModel: MapViewModel())
        .environmentObject(AudioEngine())
}
