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
                Image(systemName: "dot.radiowaves.left.and.right")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color.darkGreen)
                    .symbolEffect(.variableColor.iterative.cumulative.reversing, options: .speed(0.1))

            } else {
                Image(systemName: "dot.radiowaves.left.and.right")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
            }
        }
        .frame(width: 50, height: 30)
    }
}

#Preview {
    filterIcon(isActive: false)
}
