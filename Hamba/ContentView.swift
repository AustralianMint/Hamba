//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    
    
    //Pass var region data to show in "Map" View.
    //"Map" is embedded map interface
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

extension ContentView {
    //Variable containing map data (Long/Lat & Zoom lvl)
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.520008
                                                                                  , longitude: 13.411000), span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
