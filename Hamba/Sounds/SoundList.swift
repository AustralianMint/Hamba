//
//  SoundList.swift
//  Hamba
//
//  Created by Péter Sanyó on 22.02.24.
//

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
