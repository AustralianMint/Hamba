//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

import MapKit
import SwiftUI

//struct is a Value type that encapsulates state & behavior.
struct MapView: View {
    
    //Gives MapView (which is a View) access to user location (MapViewModel)
    @StateObject private var viewModel = MapViewModel()
    
    
    //referencing MapViewModel to show region data on Map
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(.orange)
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

//Just for Xcode Preview sake
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
