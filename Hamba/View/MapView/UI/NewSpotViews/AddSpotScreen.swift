//
//  AddSpotButton.swift
//  Hamba
//
//  Created by Alexander Görtzen on 04.06.24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct AddSpotScreen: View {
    @State private var showSheet: Bool = false

    var body: some View {
        Button {
            withAnimation {
                showSheet.toggle()
            }
        } label: {
            Image(systemName: "plus")
                .padding()
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .background(Color.darkGreen.opacity(0.5))
        .background(Material.ultraThin)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .sheet(isPresented: $showSheet) {
            AddSpotSheet()
        }
    }
}

#Preview {
    AddSpotScreen()
}
