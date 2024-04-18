//
//  filterIcon.swift
//  Hamba
//
//  Created by Péter Sanyó on 03.04.24.
//

import SwiftUI

struct filterIcon: View {
    var isActive: Bool

    var body: some View {
        ZStack {
            if isActive {
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color.darkGreen)
                    .symbolEffect(.variableColor.iterative.cumulative.reversing, options: .speed(0.1))
            } else {
                Image(systemName: "flame")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 40, height: 30)
        .padding(.horizontal, 5)
        .contentShape(Rectangle())
    }
}

#Preview {
    filterIcon(isActive: false)
}
