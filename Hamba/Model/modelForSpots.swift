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
    var spotImage = [String()]
    var iconType = String()
    var iconColor = Color(String())
    
    static var exampleItem = Spots(name: "Example Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313), spotImage: ["B-Day"], iconType: "star.circle")
}

var yellow: Color = Color.yellow
var purple: Color = Color.purple
var teal: Color = Color.teal

var locations: [Spots] = [
        //Normal Spots
        Spots(name: "The Cheeze-man Spot", coordinate: CLLocationCoordinate2D(latitude: 52.497169, longitude: 13.456173), spotImage: ["cheezeManSpot","cheezeManSpot1", "cheezeManSpot2"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Luisenstädtischer Kirchpark", coordinate: CLLocationCoordinate2D(latitude: 52.508725, longitude: 13.407724), spotImage: ["LuisenstaedtischerKirchpark"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Lohmühlenspot", coordinate: CLLocationCoordinate2D(latitude: 52.49499, longitude: 13.44643), spotImage: ["Lohmühlenspot", "Lohmühlenspot1", "imABird"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Märkischer Spot am Water", coordinate: CLLocationCoordinate2D(latitude: 52.514207, longitude: 13.413992), spotImage: ["MaerkischerSpotAmWater"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Bench am Auswertigen Amt", coordinate: CLLocationCoordinate2D(latitude: 52.512179, longitude: 13.401030), spotImage: ["benchAmAuswertigenAmt"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Volkspark Friedrichshain", coordinate: CLLocationCoordinate2D(latitude: 52.52460, longitude: 13.43232), spotImage: ["volksparkFriedrichshain"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Down Warschauer Steps", coordinate: CLLocationCoordinate2D(latitude: 52.50812, longitude: 13.45140), spotImage: ["downWarschauerSteps"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "James-Simon-Park", coordinate: CLLocationCoordinate2D(latitude: 52.521927, longitude: 13.399313), spotImage: ["jamesSimonParkBetter"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Osloer North - along water", coordinate: CLLocationCoordinate2D(latitude: 52.55672, longitude: 13.38133), spotImage: ["OsloerNorth", "OsloerNorth1"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "EastSide G4llery Lawn", coordinate: CLLocationCoordinate2D(latitude: 52.50354, longitude: 13.44310), spotImage: ["eastSideLawn"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Birb is the wirb", coordinate: CLLocationCoordinate2D(latitude: 52.50468, longitude: 13.33068), spotImage: ["birbIsTheWirb", "birbIsTheWirb"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Post-Volleyball", coordinate: CLLocationCoordinate2D(latitude: 52.49778, longitude: 13.37176), spotImage: ["postVolleyball"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Grab shell dude", coordinate: CLLocationCoordinate2D(latitude: 52.43854, longitude: 13.17658), spotImage: ["grabShellDude"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Waiting for bus", coordinate: CLLocationCoordinate2D(latitude: 52.50399, longitude: 13.41019), spotImage: ["waitingForBus"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Weißensee Spot", coordinate: CLLocationCoordinate2D(latitude: 52.55335, longitude: 13.46155), spotImage: ["weissenSeeSpot"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Good when full", coordinate: CLLocationCoordinate2D(latitude: 52.49204, longitude: 13.46932), spotImage: ["goodWhenFull"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Südkreuz Spot", coordinate: CLLocationCoordinate2D(latitude: 52.47889, longitude: 13.36181), spotImage: ["suedKreuzSpot"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Hausburg Spot", coordinate: CLLocationCoordinate2D(latitude: 52.52271, longitude: 13.45856), spotImage: ["hausburgSpot"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Schäfer Spot", coordinate: CLLocationCoordinate2D(latitude: 52.56517, longitude: 13.35932), spotImage: ["schaeferSpot"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Waldeck-Park", coordinate: CLLocationCoordinate2D(latitude: 52.50624, longitude: 13.40340), spotImage: ["waldeckPark"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Welcome to B", coordinate: CLLocationCoordinate2D(latitude: 52.52289, longitude: 13.36967), spotImage: ["WelcometoB", "WelcometoB1"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Mid Haircut", coordinate: CLLocationCoordinate2D(latitude: 52.53060, longitude: 13.39659), spotImage: ["midHaircut"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "/w the Boiz", coordinate: CLLocationCoordinate2D(latitude: 52.53960, longitude: 13.35386), spotImage: ["wTheBoiz"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Long times", coordinate: CLLocationCoordinate2D(latitude: 52.49535, longitude: 13.44796), spotImage: ["longTimes", "longTimes1"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Overview", coordinate: CLLocationCoordinate2D(latitude: 52.49433, longitude: 13.44299), spotImage: ["Overview"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "V's Ufer", coordinate: CLLocationCoordinate2D(latitude: 52.52190, longitude: 13.36933), spotImage: ["V'sUfer"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Sunday", coordinate: CLLocationCoordinate2D(latitude: 52.54249, longitude: 13.40384), spotImage: ["sunday"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "B-day", coordinate: CLLocationCoordinate2D(latitude: 52.47705, longitude: 13.40894), spotImage: ["B-day"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "LVL 1", coordinate: CLLocationCoordinate2D(latitude: 52.54749, longitude: 13.38808), spotImage: ["Lvl1"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "LVL 2", coordinate: CLLocationCoordinate2D(latitude: 52.54721, longitude: 13.38474), spotImage: ["Lvl2"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Boiz", coordinate: CLLocationCoordinate2D(latitude: 52.49611, longitude: 13.40912), spotImage: ["Boiz"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "Sid", coordinate: CLLocationCoordinate2D(latitude: 52.53174, longitude: 13.40844), spotImage: ["sid"], iconType: "star.circle", iconColor: yellow),
        Spots(name: "MUC", coordinate: CLLocationCoordinate2D(latitude: 48.15685, longitude: 11.58068), iconType: "star.circle", iconColor: yellow),
        
        //PingPongSpots
        Spots(name: "Die Jute Zwirbelwiese", coordinate: CLLocationCoordinate2D(latitude: 52.50628, longitude: 13.39600), spotImage: ["dieJuteZwirbelwiese"], iconType: "tennis.racket.circle", iconColor: purple),
        Spots(name: "Gustavo PingPong", coordinate: CLLocationCoordinate2D(latitude: 52.52525, longitude: 13.46388), spotImage: ["secondPingPongSpot"], iconType: "tennis.racket.circle", iconColor: purple),
        Spots(name: "Pong with Mosaic", coordinate: CLLocationCoordinate2D(latitude: 52.55238, longitude: 13.38673), spotImage: ["thirdPingPongSpot"], iconType: "tennis.racket.circle", iconColor: purple),
        Spots(name: "PinpPongSpot", coordinate: CLLocationCoordinate2D(latitude: 52.51023, longitude: 13.39979), spotImage: ["firstPingPongSpot"], iconType: "tennis.racket.circle", iconColor: purple),
        Spots(name: "C<>DE Pong", coordinate: CLLocationCoordinate2D(latitude: 52.49564, longitude: 13.44820), spotImage: ["fourthPingPongSpot", "fourthPingPongSpot1"], iconType: "tennis.racket.circle", iconColor: purple),
        Spots(name: "Humanplatz Pong", coordinate: CLLocationCoordinate2D(latitude: 52.54939, longitude: 13.42277), spotImage: ["HumanplatzPong"], iconType: "tennis.racket.circle", iconColor: purple),
        
        //Sridhar Spots
        Spots(name: "Märkisches Ufer Spot", coordinate: CLLocationCoordinate2D(latitude: 52.51436, longitude: 13.41584), spotImage: ["workInProgress"], iconType: "questionmark.circle", iconColor: teal),
        Spots(name: "Zillepromenade Spot", coordinate: CLLocationCoordinate2D(latitude: 52.49940, longitude: 13.47634), spotImage: ["workInProgress"], iconType: "questionmark.circle", iconColor: teal),
        Spots(name: "Spot am Nordhafen", coordinate: CLLocationCoordinate2D(latitude: 52.53773, longitude: 13.36196), spotImage: ["workInProgress"], iconType: "questionmark.circle", iconColor: teal),
        Spots(name: "Wasserturm Spot", coordinate: CLLocationCoordinate2D(latitude: 52.53366, longitude: 13.41799), spotImage: ["workInProgress"], iconType: "questionmark.circle", iconColor: teal),
]

//Spots(name: "TBD", coordinate: CLLocationCoordinate2D(latitude: 52.57264, longitude: 13.36183)),
//Spots(name: "May the lord be open", coordinate: CLLocationCoordinate2D(latitude: 52.53674, longitude: 13.41829)),
//Spots(name: "TBD", coordinate: CLLocationCoordinate2D(latitude: 52.55859, longitude: 13.35737)),
//Spots(name: "Osloer South - Bench", coordinate: CLLocationCoordinate2D(latitude: 52.55498, longitude: 13.38033)),
//Spots(name: "Bartholdy Bench", coordinate: CLLocationCoordinate2D(latitude: 52.502560, longitude: 13.376552)),
