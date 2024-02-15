//
//  mainNavBar.swift
//  Hamba
//
//  Created by Thomas Frey on 16.06.23.
//

import _MapKit_SwiftUI
import AVFoundation
import SwiftUI

struct mainNavBar: View {
    @ObservedObject var mapViewModel: MapViewModel
    @State private var soundIsOn: Bool = true
    @State private var isImageryMapType: Bool = false
    
    var body: some View {
        HStack {
            hambaFont
            hambaImage
            Spacer()
            buttonCollection
        }
        .padding(.horizontal)
        .padding(.vertical, 0)
    }
    
    var hambaFont: some View {
        Text("Hamba")
            .padding()
            .font(.system(.title, design: .serif))
    }
    
    var hambaImage: some View {
        Image(systemName: "figure.walk")
            .imageScale(.large)
            .padding(.leading, -15)
    }
    
    var buttonCollection: some View {
        HStack(alignment: .center) {
            mapStyleButton
            Divider()
            musicButton
        }
        .padding()
        .background(Material.ultraThin)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(maxHeight: 44)
    }
    
    var musicButton: some View {
        Button {
            if soundIsOn {
                audioPlayer?.pause()
                self.soundIsOn = false
                print("soundIsOn = false")
            } else {
                audioPlayer?.play()
                self.soundIsOn = true
                print("soundIsOn = true")
            }
        } label: {
            Image(systemName: soundIsOn ? "speaker.wave.3.fill" : "speaker.wave.3")
        }
    }
    
    var mapStyleButton: some View {
        Button(action: {
            // 2. Toggle the map type on button press
            isImageryMapType.toggle()
            mapViewModel.mapType = isImageryMapType ? MapStyle.imagery : MapStyle.standard
        }, label: {
            // 3. Change the button icon based on the toggle status
            Image(systemName: isImageryMapType ? "square.2.layers.3d.top.filled" : "square.2.layers.3d.bottom.filled")
        })
    }
}

struct mainNavBar_Previews: PreviewProvider {
    static var previews: some View {
        mainNavBar(mapViewModel: MapViewModel())
    }
}
