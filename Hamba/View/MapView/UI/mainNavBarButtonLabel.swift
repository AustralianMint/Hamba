//
//  mainNavBarButtonLabel.swift
//  Hamba
//
//  Created by Péter Sanyó on 03.04.24.
//

import SwiftUI

struct mainNavBarButtonLabel: View {
    var isActive: Bool
    let activeImage: String
    let passiveImage: String

    var body: some View {
        ZStack {
            if isActive {
                Image(systemName: activeImage)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                    .symbolRenderingMode(.multicolor)
                    .symbolEffect(.variableColor.iterative.cumulative.reversing, options: .speed(0.1))
            } else {
                Image(systemName: passiveImage)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
            }
        }
        .frame(width: 55, height: 45)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    let activeImage = "dial.low."
    let passiveImage = "dial.medium.fill"
    return mainNavBarButtonLabel(isActive: true, activeImage: activeImage, passiveImage: passiveImage)
        .environmentObject(AudioEngine())
}
