//
//  ColorExtension.swift
//  Hamba
//
//  Created by Alexander Görtzen on 03.06.24.
//

import Foundation
import SwiftUI

extension Color {
    init?(colorName: String) {
        switch colorName.lowercased() {
        case "red":
            self = .red
        case "orange":
            self = .orange
        case "yellow":
            self = .yellow
        case "green":
            self = .green
        case "blue":
            self = .blue
        case "purple":
            self = .purple
        case "pink":
            self = .pink
        case "black":
            self = .black
        case "white":
            self = .white
        case "gray":
            self = .gray
        default:
            return nil
        }
    }
}
