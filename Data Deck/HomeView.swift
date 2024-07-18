//
//  HomeView.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack() {
            Text("Stats")
                .font(.title)
                .fontWeight(.light)
                .padding(.top, 0)
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)){
                DataCard()
                DataCard()
                DataCard()
                DataCard()
               
            }
            .padding(.horizontal)
        }
        .padding(.top, 0)
    }
}

struct Home_prev: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
