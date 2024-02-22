//
//  SoundList.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.
//
/// Enumerates the audio files used in the application, providing a type-safe way to access audio file names and types.
///
/// This enum centralizes the management of audio file resources, ensuring that file names and types are correctly matched
/// and easily accessible throughout the application.

import Foundation

enum AudioFiles: String {
    case focusLoopCorporateMusic = "focus-loop-corporate-music-114297"
    // Add other cases for different audio files here

    var fileType: String {
        switch self {
        case .focusLoopCorporateMusic:
            return "mp3"
            // Add other file types based on their specific format
        }
    }

    var fileName: String {
        return self.rawValue
    }
}
