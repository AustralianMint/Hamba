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
    Spots(name: "Waldeck-PakrTrue", coordinate: CLLocationCoordinate2D(latitude: 52.50624, longitude: 13.40340)),
    Spots(name: "Luisenstädtischer Kirchpark", coordinate: CLLocationCoordinate2D(latitude: 52.508725, longitude: 13.407724)),
    Spots(name: "Märkischer Spot am Water", coordinate: CLLocationCoordinate2D(latitude: 52.514207, longitude: 13.413992)),
    Spots(name: "Osloer North - Bench Spot", coordinate: CLLocationCoordinate2D(latitude: 52.55672, longitude: 13.38133)),
    Spots(name: "Osloer South - Water Spot", coordinate: CLLocationCoordinate2D(latitude: 52.55498, longitude: 13.38033)),
    Spots(name: "The Cheeze-man Spot", coordinate: CLLocationCoordinate2D(latitude: 52.497169, longitude: 13.456173)),
    Spots(name: "Bench am Auswertigen Amt", coordinate: CLLocationCoordinate2D(latitude: 52.512179, longitude: 13.401030)),
    Spots(name: "Bartholdy Bench", coordinate: CLLocationCoordinate2D(latitude: 52.502560, longitude: 13.376552)),
    Spots(name: "Long times", coordinate: CLLocationCoordinate2D(latitude: 52.49535, longitude: 13.44796)),
    Spots(name: "Lohmühlenspot", coordinate: CLLocationCoordinate2D(latitude: 52.49499, longitude: 13.44643)),
    Spots(name: "Overview", coordinate: CLLocationCoordinate2D(latitude: 52.49433, longitude: 13.44299)),
    Spots(name: "Good when full", coordinate: CLLocationCoordinate2D(latitude: 52.49204, longitude: 13.46932)),
    Spots(name: "May the lord be open", coordinate: CLLocationCoordinate2D(latitude: 52.53674, longitude: 13.41829)),
    Spots(name: "TBD", coordinate: CLLocationCoordinate2D(latitude: 52.55859, longitude: 13.35737)),
    Spots(name: "Vosters' Ufer", coordinate: CLLocationCoordinate2D(latitude: 52.52190, longitude: 13.36933)),
    Spots(name: "Welcome to B", coordinate: CLLocationCoordinate2D(latitude: 52.52289, longitude: 13.36967)),
    Spots(name: "Grab shell dude", coordinate: CLLocationCoordinate2D(latitude: 52.43854, longitude: 13.17658)),
    Spots(name: "Boiz", coordinate: CLLocationCoordinate2D(latitude: 52.49611, longitude: 13.40912)),
    Spots(name: "TBD", coordinate: CLLocationCoordinate2D(latitude: 52.57264, longitude: 13.36183)),
    Spots(name: "Schäfer Spot", coordinate: CLLocationCoordinate2D(latitude: 52.56517, longitude: 13.35932)),
    Spots(name: "MUC", coordinate: CLLocationCoordinate2D(latitude: 48.15685, longitude: 11.58068))
]
