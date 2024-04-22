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

### Installation Instruction for Assesors

Note: This project has 2 parts. One is the client side which is the app we are developing for IOS and the other is the backend which is our (OS: Ubuntu 22.04.4 LTS x86_64) EC2 instance. The Postgres database and the Vapor based backend are both on this EC2 instance. We will either give you the password to ssh into the EC2 instance where you can see the most up to date code for the backend. In the repository the code that's running on the backend can be found under the "serverside" branch in the path "Hamba/HambaRemote/".   

The following instructions are to setup a local testing environment and to connect to the EC2 instance.  

Step 1: Install swift. We use swift 5.10 in the project, we assume later versions should work too, but have had issues previously with older versions of swift.

- For Mac: Just update to the newest version of Xcode.

- For Linux follow these instructions: https://www.swift.org/install/linux/ 

- For Windows: Our project does not support windows. 

Step 2: If you want to install it locally (It's already on the EC2), clone this repository with: 
'''git clone https://github.com/AustralianMint/Hamba.git''' 

Step 3: switch to "serverside" branch with:
'''git checkout serverside'''

Step 4: 

- If you are on the server you can navigate from the "ubuntu" user home directory and into "HambaRemote" with:
'''
//step 1 for EC2:
cd /home/ubuntu/Hamba/HambaRemote
//step 1 for local, go to where you cloned the repo:
cd /Hamba/HambaRemote

//step 2, if you want to start the service (the vapor app which serves as a API for our Hamba database):
swift run 
// this may take some time and make sure you are in /Hamba/HambaRemote where you will see the Package.swfit file.
'''



