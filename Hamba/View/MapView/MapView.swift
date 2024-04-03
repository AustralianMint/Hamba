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
            audioEngine.firstFadeIn(audioFile: .focusLoopCorporateMusic, fadeDuration: 7)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
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
