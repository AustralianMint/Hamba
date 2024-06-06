//
//  DetailView.swift
//  Hamba
//
//  Created by Péter Sanyó on 04.04.24.
//

import SwiftUI
import FirebaseStorage

struct DetailView: View {
    @Environment(\.dismiss) var dismiss

    @State private var imageUrl: String = ""

    var spot: Spot

    init(spot: Spot) {
        self.spot = spot
    }

    var body: some View {
        ZStack {
            backgroundSpotColor

            VStack(spacing: 5) {
                Spacer()

                header

                tabView

                coordinates

                Spacer()

                Spacer()
            }
            .padding(.horizontal, 10)
        }
        .presentationCornerRadius(24)
        .presentationContentInteraction(.automatic)
        .presentationBackground(Material.ultraThin)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
    }

    private var coordinates: some View {
        HStack {
            Spacer()

            Text("Lattitude:")
                .bold()
            Text(spot.coordinate.latitude.description.lowercased())

            Spacer()

            Text("Longitude:")
                .bold()
            Text(spot.coordinate.longitude.magnitude.description)

            Spacer()
        }
        .font(.system(.caption, design: .serif))
        .foregroundStyle(.secondary)
    }

    private var tabView: some View {
        TabView {
            ForEach(spot.spotImage, id: \.self) { imagePath in
                FirebaseImageView(imagePath: imagePath)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: spot.iconType)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(colorName: spot.iconColor) ?? .yellow)
                .background(Color.white.opacity(0.5))
                .frame(width: 23, height: 23)
                .clipShape(Circle())
                .shadow(radius: 1.5)

            Text(spot.name)
                .font(.system(.title2, design: .serif))
                .foregroundStyle(.primary)
        }
        .padding(.top, 5)
    }

    private var backgroundSpotColor: some View {
        (Color(colorName: spot.iconColor) ?? .yellow).opacity(0.2)
            .ignoresSafeArea(.all)
    }
}
