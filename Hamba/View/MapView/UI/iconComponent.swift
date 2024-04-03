//
//  iconComponent.swift
//  Hamba
//
//  Created by Péter Sanyó on 03.04.24.
//

import SwiftUI

struct iconComponent: View {
    var image: String

    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 30)
    }
}

#Preview {
    iconComponent(image: "rainbow")
}
