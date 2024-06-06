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
import FirebaseAuth

struct ContentView: View {
    @StateObject var mapViewModel = MapViewModel()
    @State private var isSignedIn = Auth.auth().currentUser != nil

    var body: some View {
        VStack {
            if isSignedIn {
                MapView(mapViewModel: mapViewModel)
            } else {
                SignInView()
            }
        }
        .onAppear {
            Auth.auth().addStateDidChangeListener { _, user in
                isSignedIn = user != nil
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
