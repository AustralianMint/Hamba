//
//  modelForSpots.swift
//  Hamba
//
//  Created by Thomas Frey on 27.08.22.
//

import Foundation
import MapKit

//Defining properties to store values of Park-locations
struct Spots: Identifiable {
    let id = UUID()
    var name = String()
    var coordinate: CLLocationCoordinate2D
    
    static var exampleItem = Spots(name: "Example Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313))
}

var locations: [Spots] = [
    Spots(name: "James-Simon-Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313)),
    Spots(name: "Waldeck-PakrTrue", coordinate: CLLocationCoordinate2D(latitude: 52.506322, longitude: 13.403756)),
    Spots(name: "Luisenstädtischer Kirchpark", coordinate: CLLocationCoordinate2D(latitude: 52.508725, longitude: 13.407724)),
    Spots(name: "Märkischer Spot am Water", coordinate: CLLocationCoordinate2D(latitude: 52.514207, longitude: 13.413992)),
    Spots(name: "Osloer North - Bench Spot", coordinate: CLLocationCoordinate2D(latitude: 52.55672, longitude: 13.38133)),
    Spots(name: "Osloer South - Water Spot", coordinate: CLLocationCoordinate2D(latitude: 52.55498, longitude: 13.38033))
]
