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
    @State public var mapType: MapStyle = .standard
    
    @State var currentAmmount: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    mainNavBar()
                }
                
                //Struct displaying the map
                ZStack(alignment: .bottomTrailing) {
                    Map(coordinateRegion: $mapViewModel.region,
                        showsUserLocation: true,
                        annotationItems: locations
                    ) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            NavigationLink {
                                Image(location.spotImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(1 + currentAmmount)
                                    .gesture(
                                        MagnificationGesture()
                                            .onChanged { value in
                                                currentAmmount = value - 1
                                            }
                                            .onEnded { value in
                                                withAnimation(.default) {
                                                    currentAmmount = 0
                                                }
                                            }
                                    )
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
                    .mapStyle(mapType)
                    
                    //Buttons to toggle which map type to display.
                    //Want to store in diffirent File.
                    VStack(alignment: .trailing) {
                        Button(action: {
                            mapType = MapStyle.imagery
                        }, label: {
                            Image(systemName: "square.2.layers.3d.top.filled")
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        
                        Button(action: {
                            mapType = MapStyle.standard
                        }, label: {
                            Image(systemName: "square.2.layers.3d.bottom.filled")
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                    .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 10))
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
