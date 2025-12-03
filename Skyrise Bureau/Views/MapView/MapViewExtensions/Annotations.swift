//
//  Annotations.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 19/11/25.
//

import SwiftUI
import MapKit
import Foundation

extension MapView {
    // MARK: Airport pin annotation
    func airportAnnotation(_ airport: Airport) -> some MapContent {
        Annotation(airport.reportCorrectCodeForUserData(userData), coordinate: airport.clLocationCoordinateItemForLocation) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(userData.deliveryHubs.contains(airport) ? Color.accentColor :(colorScheme == .dark ? Color.cyan : Color.black))
                Text(airport.reportCorrectCodeForUserData(userData))
                    .foregroundStyle(colorScheme == .dark ? .black : .cyan)
                    .padding(5)
                    .fontWidth(temporarilySelectedAirportToGetMoreInformationOn == airport ? .expanded : .compressed)
            }
            .onTapGesture {
                withAnimation {
                    temporarilySelectedAirportToGetMoreInformationOn = airport
                }
                showTemporarilySelectedAirportToGetMoreInformationOnPopUp = true
            }
            .popover(isPresented: Binding(get: {
                self.showTemporarilySelectedAirportToGetMoreInformationOnPopUp && self.temporarilySelectedAirportToGetMoreInformationOn == airport
            },set: {
                self.showTemporarilySelectedAirportToGetMoreInformationOnPopUp = $0
            })) {
                mapView(airport)
                    .onAppear {
                        print("shown")
                    }
            }
        }
    }
    
    // MARK: Aircraft locations
    func aircraftAnnotation(_ plane: FleetItem, location: Airport) -> some MapContent {
        Annotation(plane.aircraftname, coordinate: plane.planeLocationInFlight) {
            Image(systemName: "airplane")
                .font(.system(size: 15))
                .rotationEffect(
                    Angle(degrees:
                            plane.assignedRoute != nil
                          ? getBearing(from: location,
                                       to: plane.assignedRoute!.arrivalAirport)
                          : Double.random(in: 0...360)
                         )
                )
                .shadow(radius: 10)
                .foregroundStyle(plane == selectedPlane ? .indigo : .blue)
                .offset(x: 15, y: 15)
                .onTapGesture {
                    withAnimation {
                        selectedPlane = plane
                    }
                }
        }
    }
    
    // MARK: Plane route drawer
    func aircraftRouteAnnotation(_ route: Route) -> some MapContent {
            MapPolyline(coordinates: [
                route.originAirport.clLocationCoordinateItemForLocation,
                route.arrivalAirport.clLocationCoordinateItemForLocation
            ])
            .stroke(.blue, lineWidth: 5)
    }
}
