import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                Text("Stats")
                    .font(.title)
                    .fontWeight(.light)
                    .padding(.top, 0)
                    .padding(.bottom, 35)
                
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    if let weightCurrent = manager.weights.first, let weightPrevious = manager.weights.dropFirst().first {
                        DataCard(dataSet: DataSet(
                            id: 0,
                            title: "Weight",
                            subtitle: "Previous",
                            subvalue: formattedValue(weightPrevious, decimalPlaces: 1),
                            value: formattedValue(weightCurrent, decimalPlaces: 1)
                        ))
                    } else {
                        Text("No weight data available")
                    }
                    
                    if let bmiCurrent = manager.bmis.first, let bmiPrevious = manager.bmis.dropFirst().first {
                        DataCard(dataSet: DataSet(
                            id: 1,
                            title: "BMI",
                            subtitle: "Previous",
                            subvalue: formattedValue(bmiPrevious, decimalPlaces: 1),
                            value: formattedValue(bmiCurrent, decimalPlaces: 1)
                        ))
                    } else {
                        Text("No BMI data available")
                    }
                    
                    if let bodyFatCurrent = manager.bodyFats.first, let bodyFatPrevious = manager.bodyFats.dropFirst().first {
                        DataCard(dataSet: DataSet(
                            id: 2,
                            title: "Body Fat",
                            subtitle: "Previous",
                            subvalue: formattedValue(bodyFatPrevious * 100, decimalPlaces: 1) + "%",
                            value: formattedValue(bodyFatCurrent * 100, decimalPlaces: 1) + "%"
                        ))
                    } else {
                        Text("No body fat data available")
                    }
                    
                    if let activeEnergy = manager.activeEnergy {
                        DataCard(dataSet: DataSet(
                            id: 3,
                            title: "Active Energy",
                            subtitle: "Previous",
                            subvalue: formattedValue(activeEnergy.previous, decimalPlaces: 1),
                            value: formattedValue(activeEnergy.current, decimalPlaces: 1)
                        ))
                    } else {
                        Text("No active energy data available")
                    }
                    
                    if let basalEnergy = manager.basalEnergy {
                        DataCard(dataSet: DataSet(
                            id: 4,
                            title: "Basal Energy",
                            subtitle: "Previous",
                            subvalue: formattedValue(basalEnergy.previous, decimalPlaces: 1),
                            value: formattedValue(basalEnergy.current, decimalPlaces: 1)
                        ))
                    } else {
                        Text("No basal energy data available")
                    }
                    if let totalEnergy = manager.totalEnergy {
                        DataCard(dataSet: DataSet(
                            id: 5,
                            title: "Total Energy",
                            subtitle: "Previous",
                            subvalue: formattedValue(totalEnergy.previous, decimalPlaces: 1),
                            value: formattedValue(totalEnergy.current, decimalPlaces: 1)
                        ))
                    } else {
                        Text("No total energy data available")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 0)
            .onAppear {
                manager.fetchHealthData()
            }
        }
        .background(Color.clear)
    }
    
    func formattedValue(_ value: Double, decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", value)
    }
    
}

struct Home_prev: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HealthManager())
    }
}
