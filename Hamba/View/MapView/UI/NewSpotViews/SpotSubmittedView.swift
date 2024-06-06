//
//  SpotSubmittedView.swift
//  Hamba
//
//  Created by Alexander Görtzen on 04.06.24.
//

import SwiftUI

struct SpotSubmittedView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String
    @State var latitude: String
    @State var longitude: String
    @State var selectedIconType: String
    @State var selectedIconColor: String
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "tree")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                    .symbolRenderingMode(.palette)
                    .symbolEffect(.bounce, options: .speed(0.1), value: true)

                Text("Hamba")
                    .padding(3)
                    .font(.system(size: 50, weight: .heavy, design: .serif))
                    .animation(Animation.smooth(duration: 3, extraBounce: 2.0).delay(1.5), value: true)


                Text("Spot Successfully Submitted!")
                    .font(.title)
                    .padding(3)

                Text("Your spot will be reviewed ASAP.")
                    .lineLimit(1)
                    .font(.title3)
                    .padding(3)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            VStack(alignment: .leading) {
                Text("Details")
                    .font(.headline)
                    .foregroundColor(.darkGreen)
                    .padding(2)

                HStack {
                    Text("Name:")
                    Text(name)
                }
                .padding(2)

                HStack {
                    Text("Latitude:")
                    Text(latitude)
                }
                .padding(2)

                HStack {
                    Text("Longitude:")
                    Text(longitude)
                }
                .padding(2)

                HStack {
                    Text("Icon Type:")
                    Text(selectedIconType)
                }
                .padding(2)

                HStack {
                    Text("Icon Color:")
                    Text(selectedIconColor)
                }
                .padding(2)

                HStack {
                    Text("Images:")
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                .padding(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: {
                dismiss()
            }) {
                Text("OK")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.darkGreen)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
