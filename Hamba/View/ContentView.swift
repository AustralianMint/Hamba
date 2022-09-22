//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

// Foundation is pretty beefy Framework. (Hanldes Data Storage, date & time, etc.)
import Foundation
import MapKit
import SwiftUI


//struct is a 'Value type' that encapsulates state & behavior.
struct ContentView: View {
    
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                //Struct displaying the map
                Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true,  annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        NavigationLink {
                            Image("cheeseManSpotImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .blur(radius: CGFloat(1))
                            Text(location.name)
                        } label: {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.yellow)
                                .background(.white)
                                .frame(width: 22, height: 22)
                                .clipShape(Circle())
                        }
                    }
                }
                .navigationTitle("Hamba")
            }
        }
    }
    
    //Just for Xcode Preview sake
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
