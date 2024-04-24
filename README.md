# Hamba

<div style="display: flex;">
  <img width="240,5" alt="Screenshot 2022-04-06 at 09 44 25" src="https://user-images.githubusercontent.com/43207309/161922518-e9301690-4d47-4364-a4de-fd4aec1b1528.png">
  <img width="240,5" alt="hambaGitHubProgress" src="https://github.com/AustralianMint/Hamba/assets/43207309/50f54d4e-8900-4d23-b5b3-51d2e1de2bec">
  <img width="240,5" alt="Screenshot 2024-02-18 at 14 40 40" src="https://github.com/AustralianMint/Hamba/assets/43207309/6e48c2aa-265b-449f-8687-e3a4b901fb4d">
  <img width="225" alt="Gif of current Hamba 2.0 version" src="https://github.com/AustralianMint/Hamba/assets/43207309/c2804663-2dd9-450a-a3f8-6b319de5223e">
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

---

### Relational Database - Project overview:

This project has 2 parts. One is the **client side**, which is the app we are developing for IOS and the other is the **backend** which is our (OS: Ubuntu 22.04.4 LTS x86_64) EC2 instance. The Postgres database and the "Vapor" based backend are both on this EC2 instance.

We will give you the password to ssh into the EC2 instance where you can see the most up to date code for the backend. 

In the Git repository, the code that is running on the backend can be found under the ```"serverside"``` branch in the path ```"Hamba/HambaRemote/".```

The following instructions are to setup a **local testing environment** and to connect to the EC2 instance.  


---

### Connecting to the EC2 Instance:

**Step 1:** Open a command line interface and paste the following command:

```
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no ubuntu@ec2-13-48-27-141.eu-north-1.compute.amazonaws.com
```

**Step 2:** Enter the password we have supplied you with.

**Step 3:** Navigate to the following directory:
```cd /home/ubuntu/Hamba/HambaRemote```


**Step 4:** Start the service with ```swift run``` 
 
*This may take some time. Make sure that you are in /Hamba/HambaRemote directory where you will see the Package.swfit file.*

---


### Installation Instruction for Assesors (locally)

**Step 1:** Install latest version of swift. </br>


We use ```swift 5.10``` in the project, we assume later versions should work too, but have had issues previously with older versions of swift.

- For Mac: Update to the newest version of Xcode.

- For Linux follow these instructions: https://www.swift.org/install/linux/ 

- For Windows: Our project does not support windows.

**Step 2:** Clone the Hamba repository with:   

```git clone https://github.com/AustralianMint/Hamba.git``` 

(The repository is already on the EC2 instance).

**Step 3:** Checkout the "serverside" branch with:

```git checkout serverside```

**Step 4:** Navigate to where you cloned the repo and into the ```"HambaRemote"``` directory:

```cd /Hamba/HambaRemote```


**Step 5:**  Install postgres locally, if you don't have it already.
https://www.postgresql.org/download/


**Step 6:** In your terminal enter the psql environment by running:

```psql -U postgres```


and create an empyt database with the following command:


```CREATE DATABASE hamba_test;```

**Step 7:** To populate your currently empty databse, run the following command:


```psql -U postgres -d hamba_test -f /Hamba/db_test_data.sql```

***Note**, the "/Hamba/db_test_data.sql" is a file located within the Hamba git repository on the ```serverside``` branch.* 


**Step 8:** Create a credentials file.

***Note** We have created a .json file which stores the credentials to connect to the local postgres instace, which is not tracked by Git. You will manually create this ```postgresql.json``` file.*

First you create a directory by running:

```mkdir /Hamba/HambaRemote/Sources/App/Secrets```

Next create a .json file called ```postgresql.json```

In this file, paste the following:

```
{
"host": "localhost",
"user": "postgres",
"password": "<your_postgres_user_password>",
"database": "hamba_test",
"port": 5432
}
```


**Step 9:** Execute the following command in the ```Hamba/HambaRemote``` directory to start the service (the vapor app which serves as an API for our Hamba database): ```swift run```


**Step 10:** Open your browser and connect to the vapor API by entering the following url:

```http://localhost:8080/get/spots/all```

Inside the ```Hamba/HambaRemote/Sources/App/routes.swift``` you can find all the possible urls the API handles.

For example, the above URL is served by the following routes funcion:

```app.get("get", "spots", "all")```

---
