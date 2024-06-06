//
//  LocationsViewModel.swift
//  Hamba
//
//  Created by Alexander Görtzen on 03.06.24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class LocationsViewModel: ObservableObject {
    @Published var locations = [Spot]()
    private var db = Firestore.firestore()

    init() {
        fetchSpots()
    }

    func fetchSpots() {
        db.collection("locations").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let querySnapshot = querySnapshot {
                    self.locations = querySnapshot.documents.compactMap { document in
                        if let spot = try? document.data(as: Spot.self), spot.isViewable {
                            return spot
                        } else {
                            return nil
                        }
                    }
                }
            }
        }
    }
}
