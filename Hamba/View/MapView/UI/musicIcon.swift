//
//  musicIcon.swift
//  Hamba
//
//  Created by Péter Sanyó on 03.04.24.
//

import SwiftUI

struct musicIcon: View {
    var isActive: Bool

    var body: some View {
        HStack(spacing: -5) {
            iconComponent(image: isActive ? "speaker.fill" : "speaker")
                .contentTransition(.symbolEffect(.replace))
            Group {
                if isActive {
                    iconComponent(image: "rainbow")
                        .symbolRenderingMode(.multicolor)
                        .symbolEffect(.variableColor.iterative.cumulative.reversing, options: .speed(0.1))

                } else {
                    iconComponent(image: "rainbow")
                }
            }
            .rotationEffect(.degrees(90))
        }
    }
}

#Preview {
    musicIcon(isActive: false)
}
