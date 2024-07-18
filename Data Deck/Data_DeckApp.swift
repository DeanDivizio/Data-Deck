//
//  Data_DeckApp.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import SwiftUI

@main
struct Data_DeckApp: App {
    @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
