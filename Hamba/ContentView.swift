//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

import MapKit
import SwiftUI

//Defining properties to store values of Park-locations
struct Spots: Identifiable {
    let id = UUID()
    var name = String()
    var coordinate: CLLocationCoordinate2D
}

//struct is a 'Value type' that encapsulates state & behavior.
struct MapView: View {
    
    //Gives MapView (which is a View) access to user location (MapViewModel)
    @StateObject private var viewModel = MapViewModel()
    
    //Array w/ Park values ('random-access-collection' in map init)
    @State private var locations: [Spots] = [
        Spots(name: "James-Simon-Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313)),
        Spots(name: "Waldeck-PakrTrue", coordinate: CLLocationCoordinate2D(latitude: 52.506322, longitude: 13.403756)),
        Spots(name: "Luisenstädtischer Kirchpark", coordinate: CLLocationCoordinate2D(latitude: 52.508725, longitude: 13.407724))    
    ]
    
    @State private var pointOfInteres: MKPointOfInterestFilter = .excludingAll
    
    //initializing a Map in a View w/ necessary arguments
    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            showsUserLocation: true,
            annotationItems: locations,
            annotationContent: {
            location in MapAnnotation(coordinate: location.coordinate) {
                Circle()
                    .stroke(.red, lineWidth: 5.0)
                    .frame(width: 30, height: 30)
                    .blur(radius: 0.3)
            }
        }).ignoresSafeArea()
            .onAppear{
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }

//Just for Xcode Preview sake
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
        }
    }
}
