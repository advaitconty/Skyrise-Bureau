//
//  TouchbarController.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 2/12/25.
//

import SwiftUI
import SwiftData

struct TouchbarController: View {
    @Binding var indexOfSelectedPlane: Int
    @Binding var selectedPlane: FleetItem?
    @Binding var showSidebar: Bool
    @Binding var savedMapType: String
    @Binding var showTakeoffPopup: Bool
    @Binding var takeoffItems: DepartureDoneSuccessfullyItemsToShow?
    @Environment(\.modelContext) var modelContext
    @Query var userData: [UserData]
    var moidifiableUserdata: Binding<UserData> {
        Binding {
            userData.first ?? testUserData
        } set: { value in
            if let item = userData.first {
                item.planes = value.planes
                item.deliveryHubs = value.deliveryHubs
                item.airlineIataCode = value.airlineIataCode
                item.airlineName = value.airlineName
                item.name = value.name
                item.accountBalance = value.accountBalance
                item.airlineReputation = value.airlineReputation
                item.campaignEffectiveness = value.campaignEffectiveness
                item.campaignRunning = value.campaignRunning
                item.currentlyHoldingFuel = value.currentlyHoldingFuel
                item.flightAttendentHappiness = value.flightAttendentHappiness
                item.flightAttendents = value.flightAttendents
                item.fuelDiscountMultiplier = value.fuelDiscountMultiplier
                item.lastFuelPrice = value.lastFuelPrice
                item.levels = value.levels
                item.maintainanceCrew = value.maintainanceCrew
                item.maintainanceCrewHappiness = value.maintainanceCrewHappiness
                item.maxFuelHoldable = value.maxFuelHoldable
                item.pilotHappiness = value.pilotHappiness
                item.pilots = value.pilots
                item.pilotHappiness = value.pilotHappiness
                item.xp = value.xp
                print("saving userdata...")
                try? modelContext.save()
                print("saved userdata successfully")
            }
        }
    }

    
    var body: some View {
        HStack {
            if indexOfSelectedPlane == -1 && selectedPlane == nil {
                HStack {
                    Button {
                        withAnimation {
                            showSidebar.toggle()
                        }
                    } label: {
                        Image(systemName: "sidebar.left")
                    }
                    Text("Skyrise Bureau")
                        .fontWidth(.expanded)
                }
            } else {
                Button {
                    withAnimation {
                        selectedPlane = nil
                        indexOfSelectedPlane = -1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Text("\(selectedPlane!.aircraftname)")
                    .fontWidth(.expanded)
                Text("(\(selectedPlane!.registration))")
                    .fontWidth(.condensed)
                Spacer()
                if !selectedPlane!.isAirborne {
                    Button {
                        let departureStatus = moidifiableUserdata.wrappedValue.planes[indexOfSelectedPlane].departJet(moidifiableUserdata)
                        selectedPlane = moidifiableUserdata.wrappedValue.planes[indexOfSelectedPlane]
                        print(departureStatus)
                        if departureStatus.departedSuccessfully {
                            takeoffItems = DepartureDoneSuccessfullyItemsToShow(planesTakenOff: [moidifiableUserdata.wrappedValue.planes[indexOfSelectedPlane]],
                                                                                economyPassenegersServed: departureStatus.seatsUsedInPlane!.economy,
                                                                                premiumEconomyPassenegersServed: departureStatus.seatsUsedInPlane!.premiumEconomy,
                                                                                businessPassengersServed: departureStatus.seatsUsedInPlane!.business,
                                                                                firstClassPassengersServed: departureStatus.seatsUsedInPlane!.first,
                                                                                maxEconomyPassenegersServed: departureStatus.seatingConfigOfJet!.economy,
                                                                                maxPremiumEconomyPassenegersServed: departureStatus.seatingConfigOfJet!.premiumEconomy,
                                                                                maxBusinessPassengersServed: departureStatus.seatingConfigOfJet!.business,
                                                                                maxFirstClassPassengersServed: departureStatus.seatingConfigOfJet!.first,
                                                                                moneyMade: departureStatus.moneyMade!)
                            withAnimation {
                                showTakeoffPopup = true
                            }
                        }
                    } label: {
                        Text("Depart")
                            .fontWidth(.condensed)
                    }
                } else {
                    Text("Flying to \(selectedPlane!.assignedRoute!.arrivalAirport.iata)")
                        .fontWidth(.condensed)
                }
            }
        }
    }
}
