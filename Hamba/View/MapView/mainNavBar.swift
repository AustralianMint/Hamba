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
    @Environment(\.colorScheme) private var colorScheme
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
        .background(blurredEdge)
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
        .buttonStyle(.plain)
    }
    
    var mapStyleButton: some View {
        Button {
            // 2. Toggle the map type on button press
            isImageryMapType.toggle()
            mapViewModel.mapType = isImageryMapType ? MapStyle.imagery : MapStyle.standard
        } label: {
            Image(systemName: isImageryMapType ? "square.2.layers.3d.top.filled" : "square.2.layers.3d.bottom.filled")
        }
        .buttonStyle(.plain)
    }
    
    var blurredEdge: some View {
        VisualEffectView(effect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
            .mask {
                LinearGradient(
                    stops: [
                        .init(color: Color.black.opacity(1), location: 0),
                        .init(color: Color.black.opacity(0.7), location: 0.9),
                        .init(color: Color.black.opacity(0), location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
            .offset(y: -3)
    }
}

// Custom UIBlurr Effect (to not use UIKit)
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

struct mainNavBar_Previews: PreviewProvider {
    static var previews: some View {
        mainNavBar(mapViewModel: MapViewModel())
    }
}
