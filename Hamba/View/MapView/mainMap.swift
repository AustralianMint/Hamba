//
//  mainMap.swift
//  Hamba
//
//  Created by Péter Sanyó on 15.02.24.
//

import _MapKit_SwiftUI
import SwiftUI

struct mainMap: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var mapViewModel: MapViewModel

    var body: some View {
        ZStack {
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

            VStack {
                blurredEdge
                Spacer()
            }
        }
        .ignoresSafeArea()
    }

    var blurredEdge: some View {
        
        VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
            .mask {
                LinearGradient(
                    stops: [
                        .init(color: Color.black.opacity(1), location: 0),
                        .init(color: Color.black.opacity(0.9), location: 0.8),
                        .init(color: Color.black.opacity(0), location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }

            .offset(y:-3) //
            .frame(height: 110)
    }
}

// Custom UIBlurr Effect (to not use UIKit)
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

#Preview {
    mainMap(mapViewModel: MapViewModel())
}
