//
//  ContentView.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import SwiftUI
import HealthKit



struct ContentView: View {
    var body: some View {
        Text("Welcome Back")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 5.0)
            .padding(.bottom, 0)
        DDTabView()
    }}

#Preview {
    ContentView()
}
