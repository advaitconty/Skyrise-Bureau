import SwiftUI
import AppKit
import CompactSlider

struct AirplaneStoreView: View {
    @Binding var userData: UserData
    @State var searchTerm: String = ""
    @State var selectedType: String? = nil
    @Environment(\.colorScheme) var colorScheme
    let cornerRadius = 10.0
    @State var showPlaneStats: Aircraft? = nil
    @State var showPlane: Bool = false
    @State var preferedSeatingConfig: SeatingConfig = SeatingConfig(economy: 0, premiumEconomy: 0, business: 0, first: 0)
    @State var showContextScreen: Bool = false
    @State var showNotAllSeatsFilled: Bool = false
    @State var showAllSeatsFileld: Bool = false
    @State var registration: String = "SB-"
    @State var aircraftName: String = "Horizon Jet"
    
    var filteredPlanes: [Aircraft] {
        AircraftDatabase.shared.allAircraft.filter { plane in
            let matchesSearch = searchTerm.isEmpty || plane.name.localizedCaseInsensitiveContains(searchTerm) || plane.manufacturer.rawValue.localizedCaseInsensitiveContains(searchTerm)
            
            let matchesType = selectedType == nil
            
            return matchesSearch && matchesType
        }
    }
        
    var body: some View {
        if showPlane == false {
            shopView(userData)
                .transition(.move(edge: .leading))
        } else {
            if let plane = showPlaneStats {
                planeStatsView(plane: plane)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}
