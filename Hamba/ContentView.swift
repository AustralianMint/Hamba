//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

import MapKit
import SwiftUI

struct MapView: View {
    //Gives MapView (which is a view) access to user location (MapViewModel)
    @StateObject private var viewModel = MapViewModel()
    
    //variable containing map data, (zoom lvl & Long/Lat)
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.520008
                                                                                  , longitude: 13.411000), span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))

    //Pass var region data to show in "Map".
    //"Map" is embedded map interface
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
    }
}

//Just for Xcode Preview sake
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

//Handles Location Logic
final class MapViewModel: ObservableObject {
    
    //creating instance of Location Manager Class
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
        } else {
            print("Your location services are turned off. Turn them on in Settings")
        }
    }
    
    //INCOMPLETE
    func checkAppLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is disabled likely due to parental controls")
        case .denied:
            print("You have denied this app location permissions. Change this in settings")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }

    }
    
}
