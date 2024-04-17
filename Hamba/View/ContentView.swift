//
//  ContentView.swift
//  Hamba
//
//  Created by Thomas Frey on 20.02.22.
//

// Foundation is pretty beefy Framework. (Hanldes Data Storage, date & time, etc.)
import Foundation
import MapKit
import SwiftUI
import AVFoundation

struct ContentView: View {
//    @State var isActive: Bool = false
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
