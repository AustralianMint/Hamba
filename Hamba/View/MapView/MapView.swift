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
            audioEngine.playSound(sound: "focus-loop-corporate-music-114297", type: "mp3")
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
}
