//
//  SignOutIcon.swift
//  Hamba
//
//  Created by Alexander Görtzen on 04.06.24.
//

import SwiftUI

struct SignOutIcon: View {
    var body: some View {
        ZStack {
                Image(systemName: "signpost.left.fill")
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundColor(Color.darkGreen)
        }
        .frame(width: 40, height: 30)
        .padding(.horizontal, 5)
        .contentShape(Rectangle())
    }
}

#Preview {
    SignOutIcon()
}
