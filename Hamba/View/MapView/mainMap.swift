//
//  mainMap.swift
//  Hamba
//
//  Created by Péter Sanyó on 15.02.24.
//

import SwiftUI
import _MapKit_SwiftUI

struct mainMap: View {
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        Map(coordinateRegion: $mapViewModel.region,
            showsUserLocation: true,
            annotationItems: locations)
        { location in
            MapAnnotation(coordinate: location.coordinate) {
                NavigationLink {
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
}

#Preview {
    mainMap(mapViewModel: MapViewModel())
}
