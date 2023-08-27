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

//Forces .stack behaviour for NavigationView (phone/ipad)
extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

//struct is a 'Value type' that encapsulates state & behavior.
struct ContentView: View {
    
    @StateObject var mapViewModel = MapViewModel()
    @State public var soundIsON: Bool = true
    
    var body: some View {
        NavigationView {
            VStack() {
                mainNavBar()
                
                //Struct displaying the map
                Map(coordinateRegion: $mapViewModel.region,
                    showsUserLocation: true,
                    annotationItems: locations
                ) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        NavigationLink {
                            Image(location.spotImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Text(location.name)
                                .bold()
                                .font(.system(size: 27, weight: .heavy, design: .rounded))
                        } label: {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.yellow)
                                .background(.white)
                                .frame(width: 22, height: 22)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .phoneOnlyNavigationView()
        .onAppear(perform: {
            playSound(sound: "focus-loop-corporate-music-114297", type: "mp3");
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
        })
    }
    
    //Just for Xcode Preview sake
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
