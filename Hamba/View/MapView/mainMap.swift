//
//  mainMap.swift
//  Hamba
//
//  Created by Péter Sanyó on 15.02.24.
//

import _MapKit_SwiftUI
import SwiftUI

struct mainMap: View {
    @ObservedObject var mapViewModel: MapViewModel
    @ObservedObject var locationsViewModel =  LocationsViewModel()
    @State private var selectedSpot: Spot?
    @State private var isDetailViewPresented = false

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true, annotationItems: locationsViewModel.locations) { spot in
                MapAnnotation(coordinate: spot.coordinate2D) {
                    Button {
                        self.selectedSpot = spot
                        self.isDetailViewPresented = true

                    } label: {
                        Image(systemName: spot.iconType)
                            .resizable()
                            .foregroundStyle(Color(colorName: spot.iconColor) ?? .yellow)
                            .shadow(radius: 0.8)
                            .background(Color.white.opacity(0.5))
                            .frame(width: 23, height: 23)
                            .clipShape(Circle())
                    }
                    .contentShape(Rectangle())
                }
            }
            .mapStyle(mapViewModel.mapType)
            .mapControlVisibility(.hidden)
            .sheet(isPresented: Binding(
                get: { isDetailViewPresented },
                set: { isDetailViewPresented = $0 }
            )) {
                if let selectedSpot = selectedSpot {
                    DetailView(spot: selectedSpot)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    mainMap(mapViewModel: MapViewModel())
        .environmentObject(AudioEngine())
}

/*
 This is how i previously displayed an image.
 I wanna keep this in case i need the zoom ability

 Image(location.spotImage)
 .resizable()
 .aspectRatio(contentMode: .fit)
 .scaleEffect(1 + mapViewModel.currentAmmount)
 .gesture(
 MagnificationGesture()
 .onChanged { value in
 mapViewModel.currentAmmount = value - 1
 }
 .onEnded { _ in
 withAnimation(.default) {
 mapViewModel.currentAmmount = 0
 }
 }
 )
 */
