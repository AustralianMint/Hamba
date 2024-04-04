//
//  mapStyleIcon.swift
//  Hamba
//
//  Created by Péter Sanyó on 03.04.24.
//

import SwiftUI

struct mapStyleIcon: View {
    var isActive: Bool

    var body: some View {
        ZStack {
            if isActive {
                Image(systemName: "globe.europe.africa.fill")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color.darkGreen)
            } else {
                Image(systemName: "globe.europe.africa")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
            }
        }
        .frame(width: 50, height: 33)
        .contentShape(Rectangle())
    }
}

#Preview {
    mapStyleIcon(isActive: false)
}
