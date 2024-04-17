//
//  songPicker.swift
//  Hamba
//
//  Created by Péter Sanyó on 17.04.24.
//

import SwiftUI

struct songPicker: View {
    @EnvironmentObject var audioEngine: AudioEngine
    @Binding var selectedSong: AudioFiles
    
    @State private var isExpanded = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        VStack {
            songSelectionButton
            
            if isExpanded {
                selectionOptions
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .foregroundColor(Color.darkGreen)
        .background(Material.ultraThin)
        .cornerRadius(24)
    }
    
    private var songSelectionButton: some View {
        Button {
            withAnimation(.bouncy) {
                rotationAngle = isExpanded ? 0 : 180
                isExpanded.toggle()
            }
        } label: {
            Text("\(selectedSong.displayName)")
            Image(systemName: "chevron.down")
                .resizable()
                .scaledToFit()
                .rotation3DEffect(.degrees(rotationAngle), axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(width: 20, height: 10)
        }
        .buttonStyle(.plain)
    }
    
    private var selectionOptions: some View {
        VStack {
            Text("Select your sound").font(.caption)
            ForEach(AudioFiles.allCases.filter { $0 != selectedSong }, id: \.self) { file in
                Button {
                    audioEngine.changeSong(to: file, fadeDuration: 1.5)
                    withAnimation(.bouncy) {
                        selectedSong = file
                        isExpanded.toggle()
                    }
                    
                } label: {
                    Text("\(file.displayName)")
                        .padding(.vertical)
                }
                .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    @State var selectedSong = AudioFiles.hambaVibes
    return songPicker(selectedSong: $selectedSong)
}
