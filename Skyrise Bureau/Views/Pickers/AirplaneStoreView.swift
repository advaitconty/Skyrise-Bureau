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
    
    func littleSmallBoxThingy(icon: String, item: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(item)
                .fontWidth(.condensed)
        }
        .padding(5)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
    
    func buttonLabel(plane: Aircraft) -> some View {
        VStack {
            VStack {
                Image(plane.modelCode)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 350 - 50, maxHeight: CGFloat(plane.customImageHeight))
                    .padding(10)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                    .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
                    .aspectRatio(3/2, contentMode: .fit)
            }
            .padding(3)
            
            
            HStack {
                Text(plane.name)
                    .font(.system(size: 24))
                    .fontWidth(.expanded)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
            .padding(3)
            
            HStack {
                Text("$\(Int(plane.purchasePrice))")
                    .font(.system(size: 16))
                    .fontWidth(.compressed)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(3)
            
            HStack {
                littleSmallBoxThingy(icon: "ruler", item: "\(plane.maxRange)km")
                
                littleSmallBoxThingy(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                
                littleSmallBoxThingy(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
            }
            .padding(3)
            
        }
        .padding(3)
        .buttonStyle(.borderless)
        .background(colorScheme == .dark ? Color(red: 18/225, green: 18/225, blue: 18/225) : Color(red: 237/225, green: 237/225, blue: 237/225))
        .frame(width: 350 - 50)
        .shadow(color: colorScheme == .dark ? .white.opacity(0.01) : .black.opacity(0.1), radius: 15, x: 0, y: 5)
        .foregroundStyle(colorScheme == .dark ? .white : .black)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
    
    func explainationOnConfigurator() -> some View {
        ScrollView {
            HStack {
                Text("How does plane configuration work?")
                    .fontWidth(.expanded)
                Spacer()
            }
            HStack {
                Text("Plane configuration works based on the types of classes you can fit a plane with, similar to real life. These classes are classified into 4 classes:")
                    .fontWidth(.condensed)
                Spacer()
            }
            HStack {
                Text("1. Economy class, the most basic of the bunch, and it costs the cheapest\n2. Premium economy class, the higher end economy. It often is a minor bump in price, but for slightly more roomier seats and nice food. However, these take up the space of 1.5 economy seats.\n3. Business class, where it really starts getting pricy. Passengers get to enjoy a nice lie-flat bed, the second largest entertainment screen in the sky and a lot more privacy compared to economy and premium economy. However, due to the lie-flat bed, this takes up the space of 3 economy class seats, or 2 premium economy class seats.\n4. First class, for the elite and VIPs. These passengers often get to enjoy private suites in the skies, entertainment screens the size of your home TV, full floor to cabin curtains and even their own personal minibar. However, this comes at the expense of taking up the place of 4 economy seats, or 2 business class seats.")
                    .fontWidth(.condensed)
                Spacer()
            }
            HStack {
                Text("Of course as the class increases, the amount of people willing to fly on that class decreases. Economy and premium economy tend to get the most amount of passengers.")
                    .fontWidth(.condensed)
                Spacer()
            }
        }
        .padding()
    }
    
    func configuator(plane: Aircraft) -> some View {
        ScrollView {
            HStack {
                Text("Purchase Options")
                    .fontWidth(.expanded)
                Spacer()
            }
            
            // Seating
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "carseat.right")
                    Text("Economy class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.economy)", value: $preferedSeatingConfig.economy, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.economy) {
                            if preferedSeatingConfig.seatsUsed < Double(plane.maxSeats) {
                                withAnimation {
                                    showNotAllSeatsFilled = true
                                }
                            } else if preferedSeatingConfig.seatsUsed > Double(plane.maxSeats) {
                                withAnimation {
                                    showAllSeatsFileld = true
                                }
                            } else {
                                withAnimation {
                                    showNotAllSeatsFilled = false
                                    showAllSeatsFileld = false
                                }
                            }
                        }
                    Stepper("", value: $preferedSeatingConfig.economy)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "star")
                    Text("Premium economy class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.premiumEconomy)", value: $preferedSeatingConfig.premiumEconomy, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.premiumEconomy) {
                            if preferedSeatingConfig.seatsUsed < Double(plane.maxSeats) {
                                withAnimation {
                                    showNotAllSeatsFilled = true
                                }
                            } else if preferedSeatingConfig.seatsUsed > Double(plane.maxSeats) {
                                withAnimation {
                                    showAllSeatsFileld = true
                                }
                            } else {
                                withAnimation {
                                    showNotAllSeatsFilled = false
                                    showAllSeatsFileld = false
                                }
                            }
                        }
                    Stepper("", value: $preferedSeatingConfig.premiumEconomy)
                    Spacer()
                }
                
                
                HStack {
                    Spacer()
                    Image(systemName: "briefcase")
                    Text("Business class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.business)", value: $preferedSeatingConfig.business, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.business) {
                            if preferedSeatingConfig.seatsUsed < Double(plane.maxSeats) {
                                withAnimation {
                                    showNotAllSeatsFilled = true
                                }
                            } else if preferedSeatingConfig.seatsUsed > Double(plane.maxSeats) {
                                withAnimation {
                                    showAllSeatsFileld = true
                                }
                            } else {
                                withAnimation {
                                    showNotAllSeatsFilled = false
                                    showAllSeatsFileld = false
                                }
                            }
                        }
                    Stepper("", value: $preferedSeatingConfig.business)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Image(systemName: "crown")
                    Text("First class seats")
                        .fontWidth(.condensed)
                    TextField("\(plane.defaultSeating.first)", value: $preferedSeatingConfig.first, format: .number)
                        .fontWidth(.compressed)
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: preferedSeatingConfig.first) {
                            if preferedSeatingConfig.seatsUsed < Double(plane.maxSeats) {
                                withAnimation {
                                    showNotAllSeatsFilled = true
                                }
                            } else if preferedSeatingConfig.seatsUsed > Double(plane.maxSeats) {
                                withAnimation {
                                    showAllSeatsFileld = true
                                }
                            } else {
                                withAnimation {
                                    showNotAllSeatsFilled = false
                                    showAllSeatsFileld = false
                                }
                            }
                        }
                    Stepper("", value: $preferedSeatingConfig.first)
                    Spacer()
                }
                
                if showNotAllSeatsFilled {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("WARNING")
                                .fontWidth(.expanded)
                                
                        }
                        Text("Not all seats have been filled. There are \(String(format: "%.1f", Double(plane.maxSeats) - preferedSeatingConfig.seatsUsed)) worth of economy seats that you can fill up.")
                            .fontWidth(.condensed)
                    }
                    .transition(.blurReplace)
                }
                
                if showAllSeatsFileld {
                    VStack {
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill")
                                .symbolRenderingMode(.multicolor)
                            Text("ERROR")
                                .fontWidth(.expanded)
                        }
                        Text("All seats have been filled up. Please remove \(String(format: "%.1f", abs(Double(plane.maxSeats) - preferedSeatingConfig.seatsUsed))) worth of economy seats to purchase this plane.")
                            .fontWidth(.condensed)
                    }
                    .transition(.blurReplace)
                }
                
                if showAllSeatsFileld || showNotAllSeatsFilled {
                    Button {
                        showContextScreen = true
                    } label: {
                        Image(systemName: "questionmark")
                    }
                    .popover(isPresented: $showContextScreen, arrowEdge: .bottom) {
                        explainationOnConfigurator()
                            .frame(maxWidth: 600, maxHeight: 600)
                    }
                }
            }
            
            // Miscellanous
            VStack {
                HStack {
                    Text("Registration")
                        .fontWidth(.condensed)
                    TextField("SK-YBR", text: $registration)
                        .fontWidth(.condensed)
                        .textFieldStyle(.roundedBorder)
                }
                
                HStack {
                    Text("Aircraft name")
                        .fontWidth(.condensed)
                    TextField("City of Birmingham...", text: $aircraftName)
                        .fontWidth(.condensed)
                        .textFieldStyle(.roundedBorder)
                }
            }
            
            Button {
                
            } label: {
                Text("Purchase jet for $\(Int(plane.purchasePrice))")
                    .fontWidth(.condensed)
            }
        }
        .padding(8)
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    func shopView() -> some View {
        VStack {
            HStack {
                Text("Store")
                    .font(.system(size: 24))
                    .fontWidth(.expanded)
                Spacer()
            }
            HStack {
                Text("Available Cash: $1,000,000")
                    .font(.system(size: 14))
                    .fontWidth(.condensed)
                Spacer()
            }
            TextField("Search for a plane...", text: $searchTerm)
                .font(.system(size: 16))
                .fontWidth(.condensed)
                .textFieldStyle(.roundedBorder)
                .padding([.bottom], 7)
            
            ScrollView {
                LazyVStack(spacing: 7, pinnedViews: []) {
                    ForEach(filteredPlanes, id: \.id) { plane in
                        Button {
                            withAnimation {
                                showPlaneStats = plane
                                showPlane = true
                            }
                        } label: {
                            buttonLabel(plane: plane)
                        }
                        .buttonStyle(.borderless)
                        
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, -8)
            .scrollContentBackground(.hidden)
        }
        .padding()
        .frame(width: 350, height: 700)
    }
    
    func planeStatsView(plane: Aircraft) -> some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        showPlane = false
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12))
                    Text("Back")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                }
                Spacer()
            }
            Image(plane.modelCode)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            VStack {
                HStack {
                    Text(plane.name)
                        .font(.system(size: 36))
                        .fontWidth(.expanded)
                    Spacer()
                }
                Text(plane.description)
                    .font(.system(size: 16))
                    .fontWidth(.condensed)
            }
            .padding(5)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            HStack {
                littleSmallBoxThingy(icon: "ruler", item: "\(plane.maxRange)km")
                littleSmallBoxThingy(icon: "gauge.with.dots.needle.33percent", item: "\(plane.cruiseSpeed)km/h")
                littleSmallBoxThingy(icon: "carseat.right.fill", item: "\(plane.maxSeats)")
            }
            HStack {
                littleSmallBoxThingy(icon: "fuelpump", item: "\(plane.fuelBurnRate)L/km")
                littleSmallBoxThingy(icon: "road.lanes", item: "\(plane.minRunwayLength)m")
                littleSmallBoxThingy(icon: "dollarsign.circle", item: "$\(plane.maintenanceCostPerHour)/km")
            }
            VStack {
                HStack {
                    Text("Normal seating arrangement")
                        .fontWidth(.condensed)
                    Spacer()
                }
                HStack {
                    Image(systemName: "carseat.right")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.economy)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "star")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.premiumEconomy)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "briefcase")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.business)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                    Divider()
                    Image(systemName: "crown")
                        .font(.system(size: 12))
                    Text("\(plane.defaultSeating.first)")
                        .font(.system(size: 12))
                        .fontWidth(.condensed)
                }
            }
            .frame(maxWidth: 250, maxHeight: 50)
            .padding(5)
            .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            
            configuator(plane: plane)
                .onAppear {
                    preferedSeatingConfig = plane.defaultSeating
                }
            
            Button {
            // Processing for purchasing
            } label: {
                Text("Purchase for $\(String(format: ".%2f", plane.purchasePrice))")
            }
        }
        .padding()
    }
    
    var body: some View {
        if showPlane == false {
            shopView()
                .transition(.move(edge: .leading))
        } else {
            if let plane = showPlaneStats {
                planeStatsView(plane: plane)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}
