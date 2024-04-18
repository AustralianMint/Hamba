//
//  musicIcon.swift
//  Hamba
//
//  Created by Péter Sanyó on 03.04.24.
//

import SwiftUI

struct musicIcon: View {
    @Binding var soundIsActive: Bool

    var body: some View {
        HStack(spacing: -5) {
            Group {
                if soundIsActive {
                    iconComponent(image: "speaker")
                        .foregroundColor(Color.darkGreen)

                } else {
                    iconComponent(image: "speaker")
                }
            }
            .foregroundStyle(.secondary)

            Group {
                if soundIsActive {
                    iconComponent(image: "rainbow")
                        .symbolRenderingMode(.multicolor)
                        .symbolEffect(.variableColor.iterative.cumulative.reversing, options: .speed(0.1))

                } else {
                    iconComponent(image: "rainbow")
                        .foregroundStyle(.secondary)
                }
            }
            .rotationEffect(.degrees(90))
        }
        .padding(.horizontal, 1)
        .padding(.leading, 3)
        .contentShape(Rectangle())
    }
}

private struct iconComponent: View {
    var image: String

    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 30)
    }
}

//#Preview {
//    musicIcon(isActive: false)
//}
