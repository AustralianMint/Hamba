//
//  FirebaseImageView.swift
//  Hamba
//
//  Created by Alexander Görtzen on 04.06.24.
//

import SwiftUI
import FirebaseStorage

struct FirebaseImageView: View {
    let imagePath: String
    @State private var imageUrl: URL?

    var body: some View {
        if let imageUrl = imageUrl {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            ProgressView()
                .onAppear {
                    fetchImageUrl()
                }
        }
    }

    private func fetchImageUrl() {
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: imagePath)

        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error fetching image URL: \(error)")
            } else {
                self.imageUrl = url
            }
        }
    }
}
