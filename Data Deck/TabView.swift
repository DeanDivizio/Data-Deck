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
            ConfigView()
                .tag("Config")
                .tabItem{
                    Image(systemName: "gear")
                }
        }
    }
}
