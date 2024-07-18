//
//  TabView.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import Foundation

import SwiftUI

struct DDTabView: View {
    @EnvironmentObject var manager: HealthManager

    @State var selectedTab = "Home"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .padding(.top, 0)
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
                .background(
                    LinearGradient(
                       gradient: Gradient(colors: [
                           Color(red: 0.0/255, green: 0.0/255, blue: 16.0/255), // Dark Blue RGB
                           Color(red: 0.0/255, green: 16.0/255, blue: 0.0/255) // Green RGB
                       ]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing
                   )
                   .edgesIgnoringSafeArea(.all)
                           )
            ConfigView()
                .tag("Config")
                .tabItem{
                    Image(systemName: "gear")
                }
        }
    }
}

