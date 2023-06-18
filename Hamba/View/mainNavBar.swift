//
//  mainNavBar.swift
//  Hamba
//
//  Created by Thomas Frey on 16.06.23.
//

import SwiftUI
import AVFoundation

struct mainNavBar: View {
    
    @State public var soundIsON: Bool = true
    
    var body: some View {
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
    }
}

struct mainNavBar_Previews: PreviewProvider {
    static var previews: some View {
        mainNavBar()
    }
}
