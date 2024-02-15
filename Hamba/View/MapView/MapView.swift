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
            playSound(sound: "focus-loop-corporate-music-114297", type: "mp3")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
        })
    }

    var navBar: some View {
        VStack {
            mainNavBar(mapViewModel: mapViewModel)
                .padding(.top, -15)
                .background(
                    // Apply a linear gradient with a blur effect
                    LinearGradient(gradient: Gradient(colors: [Color.clear]), startPoint: .top, endPoint: .bottom)
                        .blur(radius: 0) // Adjust the blur radius as needed
                )
            Spacer()
        }
    }
}

#Preview {
    MapView(mapViewModel: MapViewModel())
}
