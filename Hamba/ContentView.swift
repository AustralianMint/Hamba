//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    //Gives MapView (which is a View) access to user location (MapViewModel)
    @StateObject private var viewModel = MapViewModel()
    
    //binding variable "region", showing it in "Map" (Model View).
    //"Map" is embedded map interface
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

//ViewModel which handles Location Logic
final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.520008
                                                                                  , longitude: 13.411000), span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
    
    //creating instance of Location Manager Class
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Your location services are turned off. Turn them on in Settings")
        }
    }
    
    //INCOMPLETE
    private func checkAppLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is disabled likely due to parental controls")
        case .denied:
            print("You have denied this app location permissions. Change this in settings")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))
        @unknown default:
            break
        }
    }
    
    //gets called when CLLocationManager Object is created, runs switch checks.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAppLocationAuthorization()
    }
    
}
