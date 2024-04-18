//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

import Foundation
import MapKit
import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some View {
        MapView(mapViewModel: mapViewModel)
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
