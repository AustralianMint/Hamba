//
//  AddSpotSheet.swift
//  Hamba
//
//  Created by Alexander Görtzen on 04.06.24.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct AddSpotSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var selectedIconType: String = "Star"
    @State private var selectedIconColor: String = "Red"
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var isSpotSubmitted: Bool = false

    let iconTypes = ["Star", "Heart", "Location"]
    let iconColors = ["Red", "Yellow", "Blue"]

    let iconTypeMapping = [
        "Star": "star.circle",
        "Heart": "heart.circle",
        "Location": "location.circle"
    ]

    let iconColorMapping = [
        "Red": "red",
        "Yellow": "yellow",
        "Blue": "blue"
    ]

    let db = Firestore.firestore()
    let storage = Storage.storage()

    // Computed property to determine if all required fields are filled
    var isInputValid: Bool {
        !name.isEmpty && !latitude.isEmpty && !longitude.isEmpty && image != nil
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                    Text("Spot Name")
                        .font(.headline)
                    Spacer()
                }
                TextField("Enter Spot Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Text("Latitude")
                        .font(.headline)
                    Spacer()
                }
                TextField("Enter Latitude", text: $latitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Text("Longitude")
                        .font(.headline)
                    Spacer()
                }
                TextField("Enter Longitude", text: $longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Text("Icon Type")
                        .font(.headline)
                    Spacer()
                }
                Picker("Icon Type", selection: $selectedIconType) {
                    ForEach(iconTypes, id: \.self) { type in
                        HStack {
                            Image(systemName: iconTypeMapping[type] ?? "star.circle")
                            Text(type)
                        }
                    }
                }
                .tint(Color.darkGreen)
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)

                HStack {
                    Text("Icon Color")
                        .font(.headline)
                    Spacer()
                }
                Picker("Icon Color", selection: $selectedIconColor) {
                    ForEach(iconColors, id: \.self) {
                        Text($0)
                    }
                }
                .tint(Color.darkGreen)
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)

                HStack {
                    Text("Image")
                        .font(.headline)
                    Spacer()
                }
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.darkGreen, lineWidth: 2))
                    } else {
                        Text("Select Image")
                            .foregroundColor(Color.darkGreen)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(image: $image)
                }

                Button(action: {
                    saveSpot()
                }) {
                    Text("Add Spot")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isInputValid ? Color.darkGreen : Color.gray)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(!isInputValid)

                Spacer()
            }
            .padding()
            .background(Color.darkGreen.opacity(0.09).edgesIgnoringSafeArea(.all))
            .navigationBarItems(leading:
                Button("Cancel") {
                dismiss()
            }.tint(Color.darkGreen))
            .navigationBarTitle("New Spot", displayMode: .inline)
            .sheet(isPresented: $isSpotSubmitted) {
                SpotSubmittedView(name: name, latitude: latitude, longitude: longitude, selectedIconType: selectedIconType, selectedIconColor: selectedIconColor, image: image)
            }
        }
    }

    func saveSpot() {
        guard let image = image else { return }

        // Validate and convert latitude and longitude to GeoPoint
        guard let lat = Double(latitude), let lon = Double(longitude) else { return }
        let coordinate = GeoPoint(latitude: lat, longitude: lon)

        // Save image to Firebase Storage
        let storageRef = storage.reference().child("\(name).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    return
                }

                // Save data to Firestore
                let spot = Spot(name: name, coordinate: coordinate, iconType: iconTypeMapping[selectedIconType] ?? "star.circle", iconColor: iconColorMapping[selectedIconColor] ?? "yellow", spotImage: ["\(name).jpg"], isViewable: false)

                do {
                    _ = try db.collection("locations").addDocument(from: spot) { error in
                        if let error = error {
                            print("Error saving spot: \(error.localizedDescription)")
                        } else {
                            isSpotSubmitted.toggle()
                        }
                    }
                } catch let error {
                    print("Error writing spot to Firestore: \(error)")
                }
            }
        }
    }
}

#Preview {
    AddSpotSheet()
}
