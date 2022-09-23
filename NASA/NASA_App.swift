//
//  Nasa_APODApp.swift
//  Nasa APOD
//
//  Created by Ivan Nazarov on 15.09.2022.
//

import SwiftUI

@main
struct NASA_App: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                MarsRoverPhotosView()
                    .tabItem {
                        Label("Mars Rover Photos", systemImage: "binoculars")
                    }
                
                APODView()
                    .tabItem {
                        Label("APOD", image: "sparkles")
                    }
                
            }
        }
    }
}
