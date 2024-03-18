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
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapViewModel.region,
                showsUserLocation: true,
                annotationItems: locations)
            { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        TabView {
                            ForEach(location.spotImage, id: \.self) { image in
                                ZStack {
                                    Image(image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .never))

                        Text(location.name)
                            .bold()
                            .font(.system(size: 27, weight: .heavy, design: .rounded))
                    } label: {
                        Image(systemName: location.iconType)
                            .resizable()
                            .foregroundStyle(location.iconColor)
                            .background(.white)
                            .frame(width: 23, height: 23)
                            .clipShape(Circle())
                    }
                }
            }
            .mapStyle(mapViewModel.mapType)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    mainMap(mapViewModel: MapViewModel())
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
