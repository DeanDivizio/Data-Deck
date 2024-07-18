//
//  CardUI.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import Foundation
import SwiftUI

struct DataCard: View {
    var body: some View{
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 5) {
                Text("260")
                    .font(.title)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom], 5)
                Text("Weight")
                    .font(.title2)
                HStack(spacing: 5) {
                    Text("Previous:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("268.5")
                        .font(.caption)
                        .foregroundColor(.teal)
                        .padding(.leading, 0.0)
                }
                .padding(.leading, 0.0)
                
            }
            .padding(.all)
            
        }
        .padding()
        
    }
}

struct DataCard_prev: PreviewProvider {
    static var previews: some View {
        DataCard()
    }
}
