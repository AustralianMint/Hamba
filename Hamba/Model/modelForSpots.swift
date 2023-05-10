//
//  modelForSpots.swift
//  Hamba
//
//  Created by Thomas Frey on 27.08.22.
//

import Foundation
import SwiftUI
import MapKit

//Defining properties to store values of Park-locations
struct Spots: Identifiable {
    let id = UUID()
    var name = String()
    var coordinate: CLLocationCoordinate2D
    var spotImage = String()
    
    static var exampleItem = Spots(name: "Example Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313), spotImage: "B-Day")
}

var locations: [Spots] = [
    Spots(name: "James-Simon-Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313), spotImage: "jamesSimonParkBetter"),
    Spots(name: "Waldeck-Park", coordinate: CLLocationCoordinate2D(latitude: 52.50624, longitude: 13.40340), spotImage: "waldeckPark"),
    Spots(name: "Luisenstädtischer Kirchpark", coordinate: CLLocationCoordinate2D(latitude: 52.508725, longitude: 13.407724), spotImage: "LuisenstaedtischerKirchpark"),
    Spots(name: "Märkischer Spot am Water", coordinate: CLLocationCoordinate2D(latitude: 52.514207, longitude: 13.413992), spotImage: "maerkischerSpotAmWater"),
    Spots(name: "Osloer North - along water", coordinate: CLLocationCoordinate2D(latitude: 52.55672, longitude: 13.38133), spotImage: "OsloerNorth"),
    Spots(name: "The Cheeze-man Spot", coordinate: CLLocationCoordinate2D(latitude: 52.497169, longitude: 13.456173), spotImage: "cheezeManSpot"),
    Spots(name: "Bench am Auswertigen Amt", coordinate: CLLocationCoordinate2D(latitude: 52.512179, longitude: 13.401030), spotImage: "benchAmAuswertigenAmt"),
    Spots(name: "Long times", coordinate: CLLocationCoordinate2D(latitude: 52.49535, longitude: 13.44796), spotImage: "longTimes"),
    Spots(name: "Lohmühlenspot", coordinate: CLLocationCoordinate2D(latitude: 52.49499, longitude: 13.44643), spotImage: "Lohmühlenspot"),
    Spots(name: "Overview", coordinate: CLLocationCoordinate2D(latitude: 52.49433, longitude: 13.44299), spotImage: "Overview"),
    Spots(name: "Good when full", coordinate: CLLocationCoordinate2D(latitude: 52.49204, longitude: 13.46932), spotImage: "goodWhenFull"),
    Spots(name: "V's Ufer", coordinate: CLLocationCoordinate2D(latitude: 52.52190, longitude: 13.36933), spotImage: "V'sUfer"),
    Spots(name: "Welcome to B", coordinate: CLLocationCoordinate2D(latitude: 52.52289, longitude: 13.36967), spotImage: "WelcometoB"),
    Spots(name: "Grab shell dude", coordinate: CLLocationCoordinate2D(latitude: 52.43854, longitude: 13.17658), spotImage: "grabShellDude"),
    Spots(name: "Boiz", coordinate: CLLocationCoordinate2D(latitude: 52.49611, longitude: 13.40912), spotImage: "Boiz"),
    Spots(name: "Schäfer Spot", coordinate: CLLocationCoordinate2D(latitude: 52.56517, longitude: 13.35932), spotImage: "schaeferSpot"),
    Spots(name: "MUC", coordinate: CLLocationCoordinate2D(latitude: 48.15685, longitude: 11.58068)),
    Spots(name: "Sid", coordinate: CLLocationCoordinate2D(latitude: 52.53174, longitude: 13.40844), spotImage: "sid"),
    Spots(name: "EastSide G4llery Lawn", coordinate: CLLocationCoordinate2D(latitude: 52.50354, longitude: 13.44310), spotImage: "eastSideLawn"),
    Spots(name: "B-day", coordinate: CLLocationCoordinate2D(latitude: 52.47705, longitude: 13.40894), spotImage: "B-day"),
    Spots(name: "/w the Boiz", coordinate: CLLocationCoordinate2D(latitude: 52.53960, longitude: 13.35386), spotImage: "wTheBoiz"),
    Spots(name: "Birb is the wirb", coordinate: CLLocationCoordinate2D(latitude: 52.50468, longitude: 13.33068), spotImage: "birbIsTheWirb"),
    Spots(name: "Waiting for bus", coordinate: CLLocationCoordinate2D(latitude: 52.50399, longitude: 13.41019), spotImage: "waitingForBus"),
    Spots(name: "Post-Volleyball", coordinate: CLLocationCoordinate2D(latitude: 52.49778, longitude: 13.37176), spotImage: "postVolleyball"),
    Spots(name: "Volkspark Friedrichshain", coordinate: CLLocationCoordinate2D(latitude: 52.52460, longitude: 13.43232), spotImage: "volksparkFriedrichshain"),
    Spots(name: "Sunday", coordinate: CLLocationCoordinate2D(latitude: 52.54249, longitude: 13.40384), spotImage: "sunday")
]

//Spots(name: "TBD", coordinate: CLLocationCoordinate2D(latitude: 52.57264, longitude: 13.36183)),
//Spots(name: "May the lord be open", coordinate: CLLocationCoordinate2D(latitude: 52.53674, longitude: 13.41829)),
//Spots(name: "TBD", coordinate: CLLocationCoordinate2D(latitude: 52.55859, longitude: 13.35737)),
//Spots(name: "Osloer South - Bench", coordinate: CLLocationCoordinate2D(latitude: 52.55498, longitude: 13.38033)),
//Spots(name: "Bartholdy Bench", coordinate: CLLocationCoordinate2D(latitude: 52.502560, longitude: 13.376552)),
