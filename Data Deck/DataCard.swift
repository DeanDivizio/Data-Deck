//
//  CardUI.swift
//  Data Deck
//
//  Created by Dean Divizio on 7/18/24.
//

import Foundation
import SwiftUI

struct DataSet {
    let id: Int
    let title: String
    let subtitle: String
    let subvalue: String
    let value: String
}

struct DataCard: View {
    @State var dataSet: DataSet
    var body: some View {
        ZStack (alignment: .leading) {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 25/255, green: 25/255, blue: 32/255),
                    Color(red: 16/255, green: 16/255, blue: 16/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(8)
            VStack(alignment: .leading, spacing: 5) {
                Text(dataSet.value)
                    .font(.title)
                    .foregroundColor(.green)
                    .padding(.bottom, 5)
                Text(dataSet.title)
                    .font(.title2)
                HStack(spacing: 5) {
                    Text(dataSet.subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(dataSet.subvalue)
                        .font(.caption)
                        .foregroundColor(.teal)
                }
            }
            .padding(25)
        }
        .padding([.bottom], 25)
    }
}

struct DataCard_prev: PreviewProvider {
    static var previews: some View {
        DataCard(dataSet: DataSet(id: 0, title: "Weight", subtitle: "Previous", subvalue: "268.5", value: "260"))
    }
}
