# Hamba

<div style="display: flex;">
  <img width="240,5" alt="Screenshot 2022-04-06 at 09 44 25" src="https://user-images.githubusercontent.com/43207309/161922518-e9301690-4d47-4364-a4de-fd4aec1b1528.png">
  <img width="240,5" alt="hambaGitHubProgress" src="https://github.com/AustralianMint/Hamba/assets/43207309/50f54d4e-8900-4d23-b5b3-51d2e1de2bec">
</div>

--- 

This application is natively developed for iOS Devices.

#### **'Hamba' will**:
- Show your current location on the Map.
- Point out tranquil Park areas/ Spots in Berlin.
- Play lovely background music

#### **Language**: 
- Swift

#### **Frameworks**: 
- SwiftUI 
- MapKit 
- AVFoundation

#### **Repository Structure**:

- **'/Hamba.xcodeproj'**: Main Xcode project file. Contains references to all the project's source files, settings and configs.
- **'/Hamba'**: Source Code Swift Files. MVVM files. Preview Content.
- **'/HambaTests'**: Unit Tests to check functionality of individual components
- **'/HambaUITests'**: User Interface tests, simulating user interactions.

```
Hamba/
├── Hamba.xcodeproj/  
├── Hamba/             
│   ├── Assets.xcassets/
│   ├── Helpers
│   │   └──playSound.swift
│   │
│   ├── Model
│   │   └──modelForSpots.swift
│   │
│   ├── Sounds
│   │   └──.mp3 file
│   │
│   ├── View
│   │   ├──ContentView.swift
│   │   ├──SplashView.swift
│   │   └──mainNavBar.swift
│   │
│   ├── ViewModel
│   │   └──MapViewModel.swift
│   │
│   ├── Hamba.entitlements
│   ├── HambaApp.swift
│   └── info.plist
│
├── HambaTests/
│   └── HambaTests.swift
│
├── HambaUITests/
│   ├── HambaUITests.swift
│   └── HambaUITestsLaunchTests.swift
│
├── .DS_Store
├── .gitignore
└── README.md

```

#### **Working towards**:
- Camera implementation
- saving to camera roll (once park visited)
- Better Map Overlays of parks.
- No default annotations from apple maps.
- Implement Database Management System (DBMS)

#### **How to start the system**: 

- Fork
- Import to Xcode
- Open Project
- Run with Xcode included iPhone Simulator

hey this is a test comment. 
