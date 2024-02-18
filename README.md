# Hamba

<div style="display: flex;">
  <img width="240,5" alt="Screenshot 2022-04-06 at 09 44 25" src="https://user-images.githubusercontent.com/43207309/161922518-e9301690-4d47-4364-a4de-fd4aec1b1528.png">
  <img width="240,5" alt="hambaGitHubProgress" src="https://github.com/AustralianMint/Hamba/assets/43207309/50f54d4e-8900-4d23-b5b3-51d2e1de2bec">
  <img width="240,5" alt="Screenshot 2024-02-18 at 14 40 40" src="https://github.com/AustralianMint/Hamba/assets/43207309/6e48c2aa-265b-449f-8687-e3a4b901fb4d">
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
│   ├── info.plist
│   ├── Hamba.entitlements
│   └── HambaApp.swift
│   │
│   ├── Model/
│   │   └──modelForSpots.swift
│   │
│   ├── ViewModel/
│   │   └──MapViewModel.swift
│   │
│   ├── View/
│   │   ├──ContentView.swift
│   │   ├──SplashView.swift
│   │   └──MapView/
│   │       ├──MapView.swift
│   │       ├──mainNavBar.swift
│   │       └──mainMap.swift
│   │  
│   ├── Helpers/
│   │   └──playSound.swift
│   │
│   ├── Extensions/
│   │   └──View+Navigation.swift
│   │
│   ├── Preview Content/
│   │   ├──Preview Assets
│   │   └──Assets
│   │
│   ├── Sounds/
│   │   └──.mp3 file
│   │
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
