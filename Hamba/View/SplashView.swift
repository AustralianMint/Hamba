//
//  SplashView.swift
//  Hamba
//
//  Created by Thomas Frey on 15.01.23.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var audioEngine: AudioEngine
    @State private var animate = false
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                VStack {
                    Image(systemName: "tree")
                        .font(.system(size: 100))
                        .foregroundColor(.green)
                        .symbolRenderingMode(.palette)
                        .symbolEffect(.bounce, options: .speed(0.1), value: animate)

                    Text("Hamba")
                        .padding()
                        .font(.system(size: 50, weight: .heavy, design: .serif))
                        .opacity(animate ? 1 : 0)
                        .animation(Animation.smooth(duration: 3, extraBounce: 2.0).delay(1.5), value: animate)
                }
            }
        }
        .onAppear {
            withAnimation {
                animate = true
            }
            audioEngine.setupAudioEngine()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(AudioEngine())
    }
}
