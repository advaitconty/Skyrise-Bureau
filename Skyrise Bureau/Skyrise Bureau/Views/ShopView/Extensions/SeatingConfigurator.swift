//
//  SeatingConfigurator.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 5/12/25.
//

import SwiftUI
import CompactSlider

extension ShopView {
    func seatingConfiguration() -> some View {
        VStack {
            Text("Seating Configuration")
                .fontWidth(.expanded)
            
            HStack {
                VStack {
                    CompactSlider(value: Binding(get: {
                        return Float(preferedSeatingConfig.economy)
                    }, set: {
                        preferedSeatingConfig.economy = Int($0)
                        
                    }), in: 0...Float(selectedPlane!.maxSeats), step: 1)
                    .compactSliderStyle(default: .vertical(.bottom))
                    .frame(width: 40, height: 400)
                    Image(systemName: "carseat.right")
                    Text("\(preferedSeatingConfig.economy)")
                        .fontWidth(.condensed)
                        .contentTransition(.numericText(countsDown: true))
                    
                    HStack {
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.economy != 0 {
                                        preferedSeatingConfig.economy -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.red)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.economy != 0 {
                                        preferedSeatingConfig.economy -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .hoverEffect()
                        }
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != preferedSeatingConfig.economy {
                                        preferedSeatingConfig.economy += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.green)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != preferedSeatingConfig.economy {
                                        preferedSeatingConfig.economy += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .hoverEffect()
                        }
                    }
                }
                
                VStack {
                    CompactSlider(value: Binding(get: {
                        return Float(preferedSeatingConfig.premiumEconomy)
                    }, set: {
                        preferedSeatingConfig.premiumEconomy = Int($0)
                        
                    }), in: 0...Float(Int(Double(selectedPlane!.maxSeats) / 1.5)), step: 1)
                    .compactSliderStyle(default: .vertical(.bottom))
                    .frame(width: 40, height: 400)
                    Image(systemName: "star")
                    Text("\(preferedSeatingConfig.premiumEconomy)")
                        .fontWidth(.condensed)
                        .contentTransition(.numericText(countsDown: true))
                    HStack {
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.premiumEconomy != 0 {
                                        preferedSeatingConfig.premiumEconomy -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.red)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.premiumEconomy != 0 {
                                        preferedSeatingConfig.premiumEconomy -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .hoverEffect()
                        }
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != Int(Double(preferedSeatingConfig.premiumEconomy) / 1.5) {
                                        preferedSeatingConfig.premiumEconomy += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.green)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != Int(Double(preferedSeatingConfig.premiumEconomy) / 1.5) {
                                        preferedSeatingConfig.premiumEconomy += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .hoverEffect()
                        }
                    }
                    
                }
                
                VStack {
                    CompactSlider(value: Binding(get: {
                        return Float(preferedSeatingConfig.business)
                    }, set: {
                        preferedSeatingConfig.business = Int($0)
                        
                    }), in: 0...Float(Int(Double(selectedPlane!.maxSeats) / 2.0)), step: 1)
                    .compactSliderStyle(default: .vertical(.bottom))
                    .frame(width: 40, height: 400)
                    Image(systemName: "briefcase")
                    Text("\(preferedSeatingConfig.business)")
                        .fontWidth(.condensed)
                        .contentTransition(.numericText(countsDown: true))
                    HStack {
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.business != 0 {
                                        preferedSeatingConfig.business -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.red)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.business != 0 {
                                        preferedSeatingConfig.business -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .hoverEffect()
                        }
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != Int(Double(preferedSeatingConfig.business) / 2.0) {
                                        preferedSeatingConfig.business += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.green)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != Int(Double(preferedSeatingConfig.business) / 2.0) {
                                        preferedSeatingConfig.business += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .hoverEffect()
                        }
                    }
                }
                
                VStack {
                    CompactSlider(value: Binding(get: {
                        return Float(preferedSeatingConfig.first)
                    }, set: {
                        preferedSeatingConfig.first = Int($0)
                        
                    }), in: 0...Float(Int(Double(selectedPlane!.maxSeats) / 4.0)), step: 1)
                    .compactSliderStyle(default: .vertical(.bottom))
                    .frame(width: 40, height: 400)
                    Image(systemName: "crown")
                    Text("\(preferedSeatingConfig.first)")
                        .fontWidth(.condensed)
                        .contentTransition(.numericText(countsDown: true))
                    HStack {
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.first != 0 {
                                        preferedSeatingConfig.first -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.red)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if preferedSeatingConfig.first != 0 {
                                        preferedSeatingConfig.first -= 1
                                    }
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                            .hoverEffect()
                        }
                        
                        if #available(iOS 26.0, *) {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != Int(Double(preferedSeatingConfig.first) / 4.0) {
                                        preferedSeatingConfig.first += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.green)
                            .hoverEffect()
                        } else {
                            Button {
                                withAnimation {
                                    if selectedPlane!.maxSeats != Int(Double(preferedSeatingConfig.first) / 4.0) {
                                        preferedSeatingConfig.first += 1
                                    }
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 10, height: 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                            .hoverEffect()
                        }
                    }
                    
                }
            }
            .onChange(of: preferedSeatingConfig) {
                if Int(preferedSeatingConfig.seatsUsed) > selectedPlane!.maxSeats {
                    withAnimation {
                        showAllSeatsFilled = true
                    }
                } else {
                    withAnimation {
                        showAllSeatsFilled = false
                    }
                }
                
                if Int(preferedSeatingConfig.seatsUsed) < selectedPlane!.maxSeats {
                    withAnimation {
                        showNotAllSeatsFullWarning = true
                    }
                } else {
                    withAnimation {
                        showNotAllSeatsFullWarning = false
                    }
                }
            }
        }
        .padding()
        .background(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        
    }
}
