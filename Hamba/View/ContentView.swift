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


//struct is a 'Value type' that encapsulates state & behavior.
struct ContentView: View {
    
    @StateObject var mapViewModel = MapViewModel()
    @State public var soundIsON: Bool = true
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack{
                    HStack{
                        Text("Hamba")
                            .padding()
                            .font(.system(.title, design: .serif))
                        Image(systemName: "figure.walk")
                            .imageScale(.large)
                            .padding(.leading, -15)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "speaker.wave.3.fill")
                    
                    Toggle("Sound", isOn: $soundIsON)
                        .onChange(of: soundIsON) { newValue in
                            if newValue {
                                audioPlayer?.play()
                            } else {
                                audioPlayer?.pause()
                            }
                        }
                        .labelsHidden()
                        .padding(.trailing)

                }
                
                //Struct displaying the map
                Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true,  annotationItems: locations) { location in
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
                .onAppear(perform: {
                    mapViewModel.checkIfLocationServicesIsEnabled()
                })
                //.accentColor(Color(.systemBlue))
                .tint(.blue)
            }
        }
        .onAppear(perform: {
            playSound(sound: "focus-loop-corporate-music-114297", type: "mp3");
        })
    }
    
    //Just for Xcode Preview sake
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
