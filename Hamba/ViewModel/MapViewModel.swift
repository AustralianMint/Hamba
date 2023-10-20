//
//  MapViewModel.swift
//  Hamba
//
//  Created by Thomas Frey on 09.03.22.
//

import MapKit
import _MapKit_SwiftUI

//Enumirations w/ map details (start point, span)
enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.411000)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.19, longitudeDelta: 0.19)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan) 
    
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
            region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    //gets called when CLLocationManager Object is created, runs switch checks.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAppLocationAuthorization()
    }
    
}

