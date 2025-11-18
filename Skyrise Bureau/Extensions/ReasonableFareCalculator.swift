//
//  ReasonableFareCalculator.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 17/11/25.
//

import Foundation

enum SeatClass: Codable {
    case economy, premiumEconomy, business, first
}

struct AirlinePricePoint: Codable {
    var airline: String
    var rating: Double
    var seatClass: SeatClass
    var pricePerKM: Double
}

let airlinePricePoints: [AirlinePricePoint] = [
    // Singapore Airlines (rating 1.0):contentReference[oaicite:10]{index=10}
    AirlinePricePoint(airline: "Singapore Airlines", rating: 1.0,  seatClass: .economy,        pricePerKM: 0.28),
    AirlinePricePoint(airline: "Singapore Airlines", rating: 1.0,  seatClass: .premiumEconomy, pricePerKM: 0.50),
    AirlinePricePoint(airline: "Singapore Airlines", rating: 1.0,  seatClass: .business,       pricePerKM: 0.90),
    AirlinePricePoint(airline: "Singapore Airlines", rating: 1.0,  seatClass: .first,          pricePerKM: 1.60),
    // Lufthansa (rating 0.8):contentReference[oaicite:11]{index=11}
    AirlinePricePoint(airline: "Lufthansa",        rating: 0.8,  seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Lufthansa",        rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.45),
    AirlinePricePoint(airline: "Lufthansa",        rating: 0.8,  seatClass: .business,       pricePerKM: 0.80),
    AirlinePricePoint(airline: "Lufthansa",        rating: 0.8,  seatClass: .first,          pricePerKM: 1.50),
    // Delta Air Lines (rating 0.6):contentReference[oaicite:12]{index=12}
    AirlinePricePoint(airline: "Delta Air Lines",  rating: 0.6,  seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Delta Air Lines",  rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.40),
    AirlinePricePoint(airline: "Delta Air Lines",  rating: 0.6,  seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Delta Air Lines",  rating: 0.6,  seatClass: .first,          pricePerKM: 1.20),
    // United Airlines (rating 0.6):contentReference[oaicite:13]{index=13}
    AirlinePricePoint(airline: "United Airlines",  rating: 0.6,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "United Airlines",  rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "United Airlines",  rating: 0.6,  seatClass: .business,       pricePerKM: 0.65),
    AirlinePricePoint(airline: "United Airlines",  rating: 0.6,  seatClass: .first,          pricePerKM: 1.10),
    // Air France (rating 0.8):contentReference[oaicite:14]{index=14}
    AirlinePricePoint(airline: "Air France",       rating: 0.8,  seatClass: .economy,        pricePerKM: 0.24),
    AirlinePricePoint(airline: "Air France",       rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.42),
    AirlinePricePoint(airline: "Air France",       rating: 0.8,  seatClass: .business,       pricePerKM: 0.75),
    AirlinePricePoint(airline: "Air France",       rating: 0.8,  seatClass: .first,          pricePerKM: 1.40),
    // ANA All Nippon (rating 1.0):contentReference[oaicite:15]{index=15}
    AirlinePricePoint(airline: "ANA All Nippon",   rating: 1.0,  seatClass: .economy,        pricePerKM: 0.26),
    AirlinePricePoint(airline: "ANA All Nippon",   rating: 1.0,  seatClass: .premiumEconomy, pricePerKM: 0.46),
    AirlinePricePoint(airline: "ANA All Nippon",   rating: 1.0,  seatClass: .business,       pricePerKM: 0.82),
    AirlinePricePoint(airline: "ANA All Nippon",   rating: 1.0,  seatClass: .first,          pricePerKM: 1.50),
    // Japan Airlines (rating 1.0):contentReference[oaicite:16]{index=16}
    AirlinePricePoint(airline: "Japan Airlines",   rating: 1.0,  seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Japan Airlines",   rating: 1.0,  seatClass: .premiumEconomy, pricePerKM: 0.44),
    AirlinePricePoint(airline: "Japan Airlines",   rating: 1.0,  seatClass: .business,       pricePerKM: 0.80),
    AirlinePricePoint(airline: "Japan Airlines",   rating: 1.0,  seatClass: .first,          pricePerKM: 1.45),
    // Emirates (rating 0.8):contentReference[oaicite:17]{index=17}
    AirlinePricePoint(airline: "Emirates",         rating: 0.8,  seatClass: .economy,        pricePerKM: 0.26),
    AirlinePricePoint(airline: "Emirates",         rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.46),
    AirlinePricePoint(airline: "Emirates",         rating: 0.8,  seatClass: .business,       pricePerKM: 0.82),
    AirlinePricePoint(airline: "Emirates",         rating: 0.8,  seatClass: .first,          pricePerKM: 1.50),
    // Ryanair (rating 0.6):contentReference[oaicite:18]{index=18}
    AirlinePricePoint(airline: "Ryanair",          rating: 0.6,  seatClass: .economy,        pricePerKM: 0.10),
    AirlinePricePoint(airline: "Ryanair",          rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.17),
    AirlinePricePoint(airline: "Ryanair",          rating: 0.6,  seatClass: .business,       pricePerKM: 0.35),
    AirlinePricePoint(airline: "Ryanair",          rating: 0.6,  seatClass: .first,          pricePerKM: 0.80),
    // easyJet (rating 0.8):contentReference[oaicite:19]{index=19}
    AirlinePricePoint(airline: "easyJet",          rating: 0.8,  seatClass: .economy,        pricePerKM: 0.12),
    AirlinePricePoint(airline: "easyJet",          rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.20),
    AirlinePricePoint(airline: "easyJet",          rating: 0.8,  seatClass: .business,       pricePerKM: 0.40),
    AirlinePricePoint(airline: "easyJet",          rating: 0.8,  seatClass: .first,          pricePerKM: 0.85),
    // IndiGo (rating 0.8):contentReference[oaicite:20]{index=20}
    AirlinePricePoint(airline: "IndiGo",           rating: 0.8,  seatClass: .economy,        pricePerKM: 0.14),
    AirlinePricePoint(airline: "IndiGo",           rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.23),
    AirlinePricePoint(airline: "IndiGo",           rating: 0.8,  seatClass: .business,       pricePerKM: 0.45),
    AirlinePricePoint(airline: "IndiGo",           rating: 0.8,  seatClass: .first,          pricePerKM: 0.90),
    // Spirit Airlines (rating 0.6):contentReference[oaicite:21]{index=21}
    AirlinePricePoint(airline: "Spirit Airlines",  rating: 0.6,  seatClass: .economy,        pricePerKM: 0.08),
    AirlinePricePoint(airline: "Spirit Airlines",  rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.13),
    AirlinePricePoint(airline: "Spirit Airlines",  rating: 0.6,  seatClass: .business,       pricePerKM: 0.30),
    AirlinePricePoint(airline: "Spirit Airlines",  rating: 0.6,  seatClass: .first,          pricePerKM: 0.70),
    // Frontier Airlines (rating 0.6):contentReference[oaicite:22]{index=22}
    AirlinePricePoint(airline: "Frontier Airlines", rating: 0.6, seatClass: .economy,       pricePerKM: 0.09),
    AirlinePricePoint(airline: "Frontier Airlines", rating: 0.6, seatClass: .premiumEconomy,pricePerKM: 0.15),
    AirlinePricePoint(airline: "Frontier Airlines", rating: 0.6, seatClass: .business,      pricePerKM: 0.32),
    AirlinePricePoint(airline: "Frontier Airlines", rating: 0.6, seatClass: .first,         pricePerKM: 0.75),
    // Qatar Airways (rating 1.0)
    AirlinePricePoint(airline: "Qatar Airways",    rating: 1.0,  seatClass: .economy,        pricePerKM: 0.27),
    AirlinePricePoint(airline: "Qatar Airways",    rating: 1.0,  seatClass: .premiumEconomy, pricePerKM: 0.48),
    AirlinePricePoint(airline: "Qatar Airways",    rating: 1.0,  seatClass: .business,       pricePerKM: 0.88),
    AirlinePricePoint(airline: "Qatar Airways",    rating: 1.0,  seatClass: .first,          pricePerKM: 1.55),
    // Cathay Pacific (rating 0.9)
    AirlinePricePoint(airline: "Cathay Pacific",   rating: 0.9,  seatClass: .economy,        pricePerKM: 0.26),
    AirlinePricePoint(airline: "Cathay Pacific",   rating: 0.9,  seatClass: .premiumEconomy, pricePerKM: 0.47),
    AirlinePricePoint(airline: "Cathay Pacific",   rating: 0.9,  seatClass: .business,       pricePerKM: 0.85),
    AirlinePricePoint(airline: "Cathay Pacific",   rating: 0.9,  seatClass: .first,          pricePerKM: 1.52),
    // British Airways (rating 0.75)
    AirlinePricePoint(airline: "British Airways",  rating: 0.75, seatClass: .economy,        pricePerKM: 0.24),
    AirlinePricePoint(airline: "British Airways",  rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.43),
    AirlinePricePoint(airline: "British Airways",  rating: 0.75, seatClass: .business,       pricePerKM: 0.78),
    AirlinePricePoint(airline: "British Airways",  rating: 0.75, seatClass: .first,          pricePerKM: 1.42),
    // Turkish Airlines (rating 0.8)
    AirlinePricePoint(airline: "Turkish Airlines", rating: 0.8,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Turkish Airlines", rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Turkish Airlines", rating: 0.8,  seatClass: .business,       pricePerKM: 0.72),
    AirlinePricePoint(airline: "Turkish Airlines", rating: 0.8,  seatClass: .first,          pricePerKM: 1.35),
    // Etihad Airways (rating 0.85)
    AirlinePricePoint(airline: "Etihad Airways",   rating: 0.85, seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Etihad Airways",   rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.45),
    AirlinePricePoint(airline: "Etihad Airways",   rating: 0.85, seatClass: .business,       pricePerKM: 0.83),
    AirlinePricePoint(airline: "Etihad Airways",   rating: 0.85, seatClass: .first,          pricePerKM: 1.48),
    // Korean Air (rating 0.9)
    AirlinePricePoint(airline: "Korean Air",       rating: 0.9,  seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Korean Air",       rating: 0.9,  seatClass: .premiumEconomy, pricePerKM: 0.45),
    AirlinePricePoint(airline: "Korean Air",       rating: 0.9,  seatClass: .business,       pricePerKM: 0.81),
    AirlinePricePoint(airline: "Korean Air",       rating: 0.9,  seatClass: .first,          pricePerKM: 1.47),
    // Air Canada (rating 0.7)
    AirlinePricePoint(airline: "Air Canada",       rating: 0.7,  seatClass: .economy,        pricePerKM: 0.23),
    AirlinePricePoint(airline: "Air Canada",       rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.41),
    AirlinePricePoint(airline: "Air Canada",       rating: 0.7,  seatClass: .business,       pricePerKM: 0.73),
    AirlinePricePoint(airline: "Air Canada",       rating: 0.7,  seatClass: .first,          pricePerKM: 1.30),
    // Qantas (rating 0.85)
    AirlinePricePoint(airline: "Qantas",           rating: 0.85, seatClass: .economy,        pricePerKM: 0.27),
    AirlinePricePoint(airline: "Qantas",           rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.48),
    AirlinePricePoint(airline: "Qantas",           rating: 0.85, seatClass: .business,       pricePerKM: 0.86),
    AirlinePricePoint(airline: "Qantas",           rating: 0.85, seatClass: .first,          pricePerKM: 1.53),
    // Southwest Airlines (rating 0.7)
    AirlinePricePoint(airline: "Southwest Airlines", rating: 0.7, seatClass: .economy,       pricePerKM: 0.18),
    AirlinePricePoint(airline: "Southwest Airlines", rating: 0.7, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Southwest Airlines", rating: 0.7, seatClass: .business,      pricePerKM: 0.60),
    AirlinePricePoint(airline: "Southwest Airlines", rating: 0.7, seatClass: .first,         pricePerKM: 1.10),
    // KLM Royal Dutch (rating 0.8)
    AirlinePricePoint(airline: "KLM Royal Dutch",  rating: 0.8,  seatClass: .economy,        pricePerKM: 0.24),
    AirlinePricePoint(airline: "KLM Royal Dutch",  rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.43),
    AirlinePricePoint(airline: "KLM Royal Dutch",  rating: 0.8,  seatClass: .business,       pricePerKM: 0.77),
    AirlinePricePoint(airline: "KLM Royal Dutch",  rating: 0.8,  seatClass: .first,          pricePerKM: 1.41),
    // Swiss International (rating 0.85)
    AirlinePricePoint(airline: "Swiss International", rating: 0.85, seatClass: .economy,     pricePerKM: 0.26),
    AirlinePricePoint(airline: "Swiss International", rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.46),
    AirlinePricePoint(airline: "Swiss International", rating: 0.85, seatClass: .business,    pricePerKM: 0.84),
    AirlinePricePoint(airline: "Swiss International", rating: 0.85, seatClass: .first,       pricePerKM: 1.51),
    // Jetstar (rating 0.65)
    AirlinePricePoint(airline: "Jetstar",          rating: 0.65, seatClass: .economy,        pricePerKM: 0.11),
    AirlinePricePoint(airline: "Jetstar",          rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "Jetstar",          rating: 0.65, seatClass: .business,       pricePerKM: 0.38),
    AirlinePricePoint(airline: "Jetstar",          rating: 0.65, seatClass: .first,          pricePerKM: 0.82),
    // AirAsia (rating 0.7)
    AirlinePricePoint(airline: "AirAsia",          rating: 0.7,  seatClass: .economy,        pricePerKM: 0.09),
    AirlinePricePoint(airline: "AirAsia",          rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.16),
    AirlinePricePoint(airline: "AirAsia",          rating: 0.7,  seatClass: .business,       pricePerKM: 0.33),
    AirlinePricePoint(airline: "AirAsia",          rating: 0.7,  seatClass: .first,          pricePerKM: 0.73),
    // Virgin Atlantic (rating 0.8)
    AirlinePricePoint(airline: "Virgin Atlantic",  rating: 0.8,  seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Virgin Atlantic",  rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.44),
    AirlinePricePoint(airline: "Virgin Atlantic",  rating: 0.8,  seatClass: .business,       pricePerKM: 0.79),
    AirlinePricePoint(airline: "Virgin Atlantic",  rating: 0.8,  seatClass: .first,          pricePerKM: 1.43),
    // EVA Air (rating 0.9)
    AirlinePricePoint(airline: "EVA Air",          rating: 0.9,  seatClass: .economy,        pricePerKM: 0.24),
    AirlinePricePoint(airline: "EVA Air",          rating: 0.9,  seatClass: .premiumEconomy, pricePerKM: 0.43),
    AirlinePricePoint(airline: "EVA Air",          rating: 0.9,  seatClass: .business,       pricePerKM: 0.79),
    AirlinePricePoint(airline: "EVA Air",          rating: 0.9,  seatClass: .first,          pricePerKM: 1.46),
    // Hainan Airlines (rating 0.75)
    AirlinePricePoint(airline: "Hainan Airlines",  rating: 0.75, seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Hainan Airlines",  rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Hainan Airlines",  rating: 0.75, seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "Hainan Airlines",  rating: 0.75, seatClass: .first,          pricePerKM: 1.28),
    // Air New Zealand (rating 0.85)
    AirlinePricePoint(airline: "Air New Zealand",  rating: 0.85, seatClass: .economy,        pricePerKM: 0.26),
    AirlinePricePoint(airline: "Air New Zealand",  rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.47),
    AirlinePricePoint(airline: "Air New Zealand",  rating: 0.85, seatClass: .business,       pricePerKM: 0.84),
    AirlinePricePoint(airline: "Air New Zealand",  rating: 0.85, seatClass: .first,          pricePerKM: 1.49),
    // TAP Air Portugal (rating 0.7)
    AirlinePricePoint(airline: "TAP Air Portugal", rating: 0.7,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "TAP Air Portugal", rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.37),
    AirlinePricePoint(airline: "TAP Air Portugal", rating: 0.7,  seatClass: .business,       pricePerKM: 0.69),
    AirlinePricePoint(airline: "TAP Air Portugal", rating: 0.7,  seatClass: .first,          pricePerKM: 1.25),
    // Finnair (rating 0.8)
    AirlinePricePoint(airline: "Finnair",          rating: 0.8,  seatClass: .economy,        pricePerKM: 0.23),
    AirlinePricePoint(airline: "Finnair",          rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.41),
    AirlinePricePoint(airline: "Finnair",          rating: 0.8,  seatClass: .business,       pricePerKM: 0.75),
    AirlinePricePoint(airline: "Finnair",          rating: 0.8,  seatClass: .first,          pricePerKM: 1.38),
    // Scandinavian Airlines (rating 0.75)
    AirlinePricePoint(airline: "Scandinavian Airlines", rating: 0.75, seatClass: .economy,   pricePerKM: 0.23),
    AirlinePricePoint(airline: "Scandinavian Airlines", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.40),
    AirlinePricePoint(airline: "Scandinavian Airlines", rating: 0.75, seatClass: .business,  pricePerKM: 0.74),
    AirlinePricePoint(airline: "Scandinavian Airlines", rating: 0.75, seatClass: .first,     pricePerKM: 1.36),
    // Iberia (rating 0.75)
    AirlinePricePoint(airline: "Iberia",           rating: 0.75, seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Iberia",           rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "Iberia",           rating: 0.75, seatClass: .business,       pricePerKM: 0.72),
    AirlinePricePoint(airline: "Iberia",           rating: 0.75, seatClass: .first,          pricePerKM: 1.33),
    // Aer Lingus (rating 0.75)
    AirlinePricePoint(airline: "Aer Lingus",       rating: 0.75, seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Aer Lingus",       rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Aer Lingus",       rating: 0.75, seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Aer Lingus",       rating: 0.75, seatClass: .first,          pricePerKM: 1.30),
    // China Southern (rating 0.7)
    AirlinePricePoint(airline: "China Southern",   rating: 0.7,  seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "China Southern",   rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "China Southern",   rating: 0.7,  seatClass: .business,       pricePerKM: 0.65),
    AirlinePricePoint(airline: "China Southern",   rating: 0.7,  seatClass: .first,          pricePerKM: 1.22),
    // China Eastern (rating 0.7)
    AirlinePricePoint(airline: "China Eastern",    rating: 0.7,  seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "China Eastern",    rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "China Eastern",    rating: 0.7,  seatClass: .business,       pricePerKM: 0.64),
    AirlinePricePoint(airline: "China Eastern",    rating: 0.7,  seatClass: .first,          pricePerKM: 1.20),
    // Air China (rating 0.75)
    AirlinePricePoint(airline: "Air China",        rating: 0.75, seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Air China",        rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Air China",        rating: 0.75, seatClass: .business,       pricePerKM: 0.67),
    AirlinePricePoint(airline: "Air China",        rating: 0.75, seatClass: .first,          pricePerKM: 1.26),
    // Garuda Indonesia (rating 0.75)
    AirlinePricePoint(airline: "Garuda Indonesia", rating: 0.75, seatClass: .economy,        pricePerKM: 0.18),
    AirlinePricePoint(airline: "Garuda Indonesia", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Garuda Indonesia", rating: 0.75, seatClass: .business,       pricePerKM: 0.62),
    AirlinePricePoint(airline: "Garuda Indonesia", rating: 0.75, seatClass: .first,          pricePerKM: 1.18),
    // Thai Airways (rating 0.75)
    AirlinePricePoint(airline: "Thai Airways",     rating: 0.75, seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Thai Airways",     rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Thai Airways",     rating: 0.75, seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "Thai Airways",     rating: 0.75, seatClass: .first,          pricePerKM: 1.27),
    // Malaysia Airlines (rating 0.75)
    AirlinePricePoint(airline: "Malaysia Airlines", rating: 0.75, seatClass: .economy,       pricePerKM: 0.19),
    AirlinePricePoint(airline: "Malaysia Airlines", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "Malaysia Airlines", rating: 0.75, seatClass: .business,      pricePerKM: 0.65),
    AirlinePricePoint(airline: "Malaysia Airlines", rating: 0.75, seatClass: .first,         pricePerKM: 1.23),
    // Vietnam Airlines (rating 0.7)
    AirlinePricePoint(airline: "Vietnam Airlines", rating: 0.7,  seatClass: .economy,        pricePerKM: 0.17),
    AirlinePricePoint(airline: "Vietnam Airlines", rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.30),
    AirlinePricePoint(airline: "Vietnam Airlines", rating: 0.7,  seatClass: .business,       pricePerKM: 0.58),
    AirlinePricePoint(airline: "Vietnam Airlines", rating: 0.7,  seatClass: .first,          pricePerKM: 1.12),
    // Alaska Airlines (rating 0.8)
    AirlinePricePoint(airline: "Alaska Airlines",  rating: 0.8,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Alaska Airlines",  rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Alaska Airlines",  rating: 0.8,  seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "Alaska Airlines",  rating: 0.8,  seatClass: .first,          pricePerKM: 1.24),
    // JetBlue Airways (rating 0.75)
    AirlinePricePoint(airline: "JetBlue Airways",  rating: 0.75, seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "JetBlue Airways",  rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "JetBlue Airways",  rating: 0.75, seatClass: .business,       pricePerKM: 0.64),
    AirlinePricePoint(airline: "JetBlue Airways",  rating: 0.75, seatClass: .first,          pricePerKM: 1.19),
    // Hawaiian Airlines (rating 0.75)
    AirlinePricePoint(airline: "Hawaiian Airlines", rating: 0.75, seatClass: .economy,       pricePerKM: 0.22),
    AirlinePricePoint(airline: "Hawaiian Airlines", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "Hawaiian Airlines", rating: 0.75, seatClass: .business,      pricePerKM: 0.71),
    AirlinePricePoint(airline: "Hawaiian Airlines", rating: 0.75, seatClass: .first,         pricePerKM: 1.31),
    // Wizz Air (rating 0.65)
    AirlinePricePoint(airline: "Wizz Air",         rating: 0.65, seatClass: .economy,        pricePerKM: 0.10),
    AirlinePricePoint(airline: "Wizz Air",         rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.18),
    AirlinePricePoint(airline: "Wizz Air",         rating: 0.65, seatClass: .business,       pricePerKM: 0.36),
    AirlinePricePoint(airline: "Wizz Air",         rating: 0.65, seatClass: .first,          pricePerKM: 0.78),
    // Norwegian Air (rating 0.7)
    AirlinePricePoint(airline: "Norwegian Air",    rating: 0.7,  seatClass: .economy,        pricePerKM: 0.15),
    AirlinePricePoint(airline: "Norwegian Air",    rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.27),
    AirlinePricePoint(airline: "Norwegian Air",    rating: 0.7,  seatClass: .business,       pricePerKM: 0.52),
    AirlinePricePoint(airline: "Norwegian Air",    rating: 0.7,  seatClass: .first,          pricePerKM: 1.05),
    // Vueling (rating 0.7)
    AirlinePricePoint(airline: "Vueling",          rating: 0.7,  seatClass: .economy,        pricePerKM: 0.13),
    AirlinePricePoint(airline: "Vueling",          rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.23),
    AirlinePricePoint(airline: "Vueling",          rating: 0.7,  seatClass: .business,       pricePerKM: 0.44),
    AirlinePricePoint(airline: "Vueling",          rating: 0.7,  seatClass: .first,          pricePerKM: 0.88),
    // Pegasus Airlines (rating 0.65)
    AirlinePricePoint(airline: "Pegasus Airlines", rating: 0.65, seatClass: .economy,        pricePerKM: 0.11),
    AirlinePricePoint(airline: "Pegasus Airlines", rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "Pegasus Airlines", rating: 0.65, seatClass: .business,       pricePerKM: 0.37),
    AirlinePricePoint(airline: "Pegasus Airlines", rating: 0.65, seatClass: .first,          pricePerKM: 0.79),
    // Scoot (rating 0.7)
    AirlinePricePoint(airline: "Scoot",            rating: 0.7,  seatClass: .economy,        pricePerKM: 0.12),
    AirlinePricePoint(airline: "Scoot",            rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.21),
    AirlinePricePoint(airline: "Scoot",            rating: 0.7,  seatClass: .business,       pricePerKM: 0.42),
    AirlinePricePoint(airline: "Scoot",            rating: 0.7,  seatClass: .first,          pricePerKM: 0.86),
    // Cebu Pacific (rating 0.65)
    AirlinePricePoint(airline: "Cebu Pacific",     rating: 0.65, seatClass: .economy,        pricePerKM: 0.10),
    AirlinePricePoint(airline: "Cebu Pacific",     rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.17),
    AirlinePricePoint(airline: "Cebu Pacific",     rating: 0.65, seatClass: .business,       pricePerKM: 0.34),
    AirlinePricePoint(airline: "Cebu Pacific",     rating: 0.65, seatClass: .first,          pricePerKM: 0.76),
    // Allegiant Air (rating 0.6)
    AirlinePricePoint(airline: "Allegiant Air",    rating: 0.6,  seatClass: .economy,        pricePerKM: 0.09),
    AirlinePricePoint(airline: "Allegiant Air",    rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.16),
    AirlinePricePoint(airline: "Allegiant Air",    rating: 0.6,  seatClass: .business,       pricePerKM: 0.31),
    AirlinePricePoint(airline: "Allegiant Air",    rating: 0.6,  seatClass: .first,          pricePerKM: 0.72),
    // Sun Country Airlines (rating 0.65)
    AirlinePricePoint(airline: "Sun Country Airlines", rating: 0.65, seatClass: .economy,    pricePerKM: 0.11),
    AirlinePricePoint(airline: "Sun Country Airlines", rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "Sun Country Airlines", rating: 0.65, seatClass: .business,   pricePerKM: 0.38),
    AirlinePricePoint(airline: "Sun Country Airlines", rating: 0.65, seatClass: .first,      pricePerKM: 0.81),
    // Avianca (rating 0.7)
    AirlinePricePoint(airline: "Avianca",          rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Avianca",          rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Avianca",          rating: 0.7,  seatClass: .business,       pricePerKM: 0.67),
    AirlinePricePoint(airline: "Avianca",          rating: 0.7,  seatClass: .first,          pricePerKM: 1.24),
    // Copa Airlines (rating 0.75)
    AirlinePricePoint(airline: "Copa Airlines",    rating: 0.75, seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Copa Airlines",    rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Copa Airlines",    rating: 0.75, seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Copa Airlines",    rating: 0.75, seatClass: .first,          pricePerKM: 1.29),
    // LATAM Airlines (rating 0.7)
    AirlinePricePoint(airline: "LATAM Airlines",   rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "LATAM Airlines",   rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "LATAM Airlines",   rating: 0.7,  seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "LATAM Airlines",   rating: 0.7,  seatClass: .first,          pricePerKM: 1.25),
    // Aeromexico (rating 0.7)
    AirlinePricePoint(airline: "Aeromexico",       rating: 0.7,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Aeromexico",       rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.37),
    AirlinePricePoint(airline: "Aeromexico",       rating: 0.7,  seatClass: .business,       pricePerKM: 0.69),
    AirlinePricePoint(airline: "Aeromexico",       rating: 0.7,  seatClass: .first,          pricePerKM: 1.26),
    // Oman Air (rating 0.8)
    AirlinePricePoint(airline: "Oman Air",         rating: 0.8,  seatClass: .economy,        pricePerKM: 0.23),
    AirlinePricePoint(airline: "Oman Air",         rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.41),
    AirlinePricePoint(airline: "Oman Air",         rating: 0.8,  seatClass: .business,       pricePerKM: 0.76),
    AirlinePricePoint(airline: "Oman Air",         rating: 0.8,  seatClass: .first,          pricePerKM: 1.40),
    // Saudia (rating 0.7)
    AirlinePricePoint(airline: "Saudia",           rating: 0.7,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Saudia",           rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Saudia",           rating: 0.7,  seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Saudia",           rating: 0.7,  seatClass: .first,          pricePerKM: 1.30),
    // Gulf Air (rating 0.7)
    AirlinePricePoint(airline: "Gulf Air",         rating: 0.7,  seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Gulf Air",         rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "Gulf Air",         rating: 0.7,  seatClass: .business,       pricePerKM: 0.72),
    AirlinePricePoint(airline: "Gulf Air",         rating: 0.7,  seatClass: .first,          pricePerKM: 1.32),
    // Ethiopian Airlines (rating 0.75)
    AirlinePricePoint(airline: "Ethiopian Airlines", rating: 0.75, seatClass: .economy,      pricePerKM: 0.18),
    AirlinePricePoint(airline: "Ethiopian Airlines", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Ethiopian Airlines", rating: 0.75, seatClass: .business,     pricePerKM: 0.62),
    AirlinePricePoint(airline: "Ethiopian Airlines", rating: 0.75, seatClass: .first,        pricePerKM: 1.20),
    // Kenya Airways (rating 0.7)
    AirlinePricePoint(airline: "Kenya Airways",    rating: 0.7,  seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "Kenya Airways",    rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "Kenya Airways",    rating: 0.7,  seatClass: .business,       pricePerKM: 0.64),
    AirlinePricePoint(airline: "Kenya Airways",    rating: 0.7,  seatClass: .first,          pricePerKM: 1.21),
    // South African Airways (rating 0.65)
    AirlinePricePoint(airline: "South African Airways", rating: 0.65, seatClass: .economy,   pricePerKM: 0.18),
    AirlinePricePoint(airline: "South African Airways", rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "South African Airways", rating: 0.65, seatClass: .business,  pricePerKM: 0.61),
    AirlinePricePoint(airline: "South African Airways", rating: 0.65, seatClass: .first,     pricePerKM: 1.17),
    // Asiana Airlines (rating 0.85)
    AirlinePricePoint(airline: "Asiana Airlines",  rating: 0.85, seatClass: .economy,        pricePerKM: 0.24),
    AirlinePricePoint(airline: "Asiana Airlines",  rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.43),
    AirlinePricePoint(airline: "Asiana Airlines",  rating: 0.85, seatClass: .business,       pricePerKM: 0.78),
    AirlinePricePoint(airline: "Asiana Airlines",  rating: 0.85, seatClass: .first,          pricePerKM: 1.44),
    // Vietnam Bamboo Airways (rating 0.7)
    AirlinePricePoint(airline: "Bamboo Airways",   rating: 0.7,  seatClass: .economy,        pricePerKM: 0.16),
    AirlinePricePoint(airline: "Bamboo Airways",   rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.29),
    AirlinePricePoint(airline: "Bamboo Airways",   rating: 0.7,  seatClass: .business,       pricePerKM: 0.56),
    AirlinePricePoint(airline: "Bamboo Airways",   rating: 0.7,  seatClass: .first,          pricePerKM: 1.10),
    // VietJet Air (rating 0.65)
    AirlinePricePoint(airline: "VietJet Air",      rating: 0.65, seatClass: .economy,        pricePerKM: 0.11),
    AirlinePricePoint(airline: "VietJet Air",      rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "VietJet Air",      rating: 0.65, seatClass: .business,       pricePerKM: 0.38),
    AirlinePricePoint(airline: "VietJet Air",      rating: 0.65, seatClass: .first,          pricePerKM: 0.80),
    // Philippine Airlines (rating 0.7)
    AirlinePricePoint(airline: "Philippine Airlines", rating: 0.7, seatClass: .economy,      pricePerKM: 0.18),
    AirlinePricePoint(airline: "Philippine Airlines", rating: 0.7, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Philippine Airlines", rating: 0.7, seatClass: .business,     pricePerKM: 0.62),
    AirlinePricePoint(airline: "Philippine Airlines", rating: 0.7, seatClass: .first,        pricePerKM: 1.18),
    // Vistara (rating 0.8)
    AirlinePricePoint(airline: "Vistara",          rating: 0.8,  seatClass: .economy,        pricePerKM: 0.15),
    AirlinePricePoint(airline: "Vistara",          rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.27),
    AirlinePricePoint(airline: "Vistara",          rating: 0.8,  seatClass: .business,       pricePerKM: 0.52),
    AirlinePricePoint(airline: "Vistara",          rating: 0.8,  seatClass: .first,          pricePerKM: 1.02),
    // Air India (rating 0.65)
    AirlinePricePoint(airline: "Air India",        rating: 0.65, seatClass: .economy,        pricePerKM: 0.16),
    AirlinePricePoint(airline: "Air India",        rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.29),
    AirlinePricePoint(airline: "Air India",        rating: 0.65, seatClass: .business,       pricePerKM: 0.55),
    AirlinePricePoint(airline: "Air India",        rating: 0.65, seatClass: .first,          pricePerKM: 1.08),
    // SpiceJet (rating 0.65)
    AirlinePricePoint(airline: "SpiceJet",         rating: 0.65, seatClass: .economy,        pricePerKM: 0.12),
    AirlinePricePoint(airline: "SpiceJet",         rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.21),
    AirlinePricePoint(airline: "SpiceJet",         rating: 0.65, seatClass: .business,       pricePerKM: 0.41),
    AirlinePricePoint(airline: "SpiceJet",         rating: 0.65, seatClass: .first,          pricePerKM: 0.84),
    // LOT Polish Airlines (rating 0.7)
    AirlinePricePoint(airline: "LOT Polish Airlines", rating: 0.7, seatClass: .economy,      pricePerKM: 0.20),
    AirlinePricePoint(airline: "LOT Polish Airlines", rating: 0.7, seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "LOT Polish Airlines", rating: 0.7, seatClass: .business,     pricePerKM: 0.67),
    AirlinePricePoint(airline: "LOT Polish Airlines", rating: 0.7, seatClass: .first,        pricePerKM: 1.24),
    // Austrian Airlines (rating 0.75)
    AirlinePricePoint(airline: "Austrian Airlines", rating: 0.75, seatClass: .economy,       pricePerKM: 0.23),
    AirlinePricePoint(airline: "Austrian Airlines", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.41),
    AirlinePricePoint(airline: "Austrian Airlines", rating: 0.75, seatClass: .business,      pricePerKM: 0.75),
    AirlinePricePoint(airline: "Austrian Airlines", rating: 0.75, seatClass: .first,         pricePerKM: 1.37),
    // Brussels Airlines (rating 0.7)
    AirlinePricePoint(airline: "Brussels Airlines", rating: 0.7, seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Brussels Airlines", rating: 0.7, seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "Brussels Airlines", rating: 0.7, seatClass: .business,       pricePerKM: 0.73),
    AirlinePricePoint(airline: "Brussels Airlines", rating: 0.7, seatClass: .first,          pricePerKM: 1.34),
    // Icelandair (rating 0.75)
    AirlinePricePoint(airline: "Icelandair",       rating: 0.75, seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Icelandair",       rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.40),
    AirlinePricePoint(airline: "Icelandair",       rating: 0.75, seatClass: .business,       pricePerKM: 0.74),
    AirlinePricePoint(airline: "Icelandair",       rating: 0.75, seatClass: .first,          pricePerKM: 1.35),
    // WestJet (rating 0.7)
    AirlinePricePoint(airline: "WestJet",          rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "WestJet",          rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "WestJet",          rating: 0.7,  seatClass: .business,       pricePerKM: 0.66),
    AirlinePricePoint(airline: "WestJet",          rating: 0.7,  seatClass: .first,          pricePerKM: 1.22),
    // Porter Airlines (rating 0.75)
    AirlinePricePoint(airline: "Porter Airlines",  rating: 0.75, seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Porter Airlines",  rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Porter Airlines",  rating: 0.75, seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Porter Airlines",  rating: 0.75, seatClass: .first,          pricePerKM: 1.28),
    // American Airlines (rating 0.6)
    AirlinePricePoint(airline: "American Airlines",  rating: 0.6,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "American Airlines",  rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "American Airlines",  rating: 0.6,  seatClass: .business,       pricePerKM: 0.69),
    AirlinePricePoint(airline: "American Airlines",  rating: 0.6,  seatClass: .first,          pricePerKM: 1.18),
    // Virgin Australia (rating 0.8)
    AirlinePricePoint(airline: "Virgin Australia",   rating: 0.8,  seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Virgin Australia",   rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.45),
    AirlinePricePoint(airline: "Virgin Australia",   rating: 0.8,  seatClass: .business,       pricePerKM: 0.80),
    AirlinePricePoint(airline: "Virgin Australia",   rating: 0.8,  seatClass: .first,          pricePerKM: 1.45),
    // Azul Brazilian Airlines (rating 0.75)
    AirlinePricePoint(airline: "Azul Brazilian Airlines", rating: 0.75, seatClass: .economy,   pricePerKM: 0.19),
    AirlinePricePoint(airline: "Azul Brazilian Airlines", rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.35),
    AirlinePricePoint(airline: "Azul Brazilian Airlines", rating: 0.75, seatClass: .business,  pricePerKM: 0.66),
    AirlinePricePoint(airline: "Azul Brazilian Airlines", rating: 0.75, seatClass: .first,     pricePerKM: 1.22),
    // Aeroflot (rating 0.7)
    AirlinePricePoint(airline: "Aeroflot",         rating: 0.7,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Aeroflot",         rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Aeroflot",         rating: 0.7,  seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Aeroflot",         rating: 0.7,  seatClass: .first,          pricePerKM: 1.28),
    // El Al (rating 0.75)
    AirlinePricePoint(airline: "El Al",            rating: 0.75, seatClass: .economy,        pricePerKM: 0.23),
    AirlinePricePoint(airline: "El Al",            rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.41),
    AirlinePricePoint(airline: "El Al",            rating: 0.75, seatClass: .business,       pricePerKM: 0.76),
    AirlinePricePoint(airline: "El Al",            rating: 0.75, seatClass: .first,          pricePerKM: 1.38),
    // Fiji Airways (rating 0.8)
    AirlinePricePoint(airline: "Fiji Airways",     rating: 0.8,  seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Fiji Airways",     rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.45),
    AirlinePricePoint(airline: "Fiji Airways",     rating: 0.8,  seatClass: .business,       pricePerKM: 0.81),
    AirlinePricePoint(airline: "Fiji Airways",     rating: 0.8,  seatClass: .first,          pricePerKM: 1.48),
    // GOL Transportes Aéreos (rating 0.65)
    AirlinePricePoint(airline: "GOL Transportes Aéreos", rating: 0.65, seatClass: .economy,        pricePerKM: 0.11),
    AirlinePricePoint(airline: "GOL Transportes Aéreos", rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "GOL Transportes Aéreos", rating: 0.65, seatClass: .business,       pricePerKM: 0.37),
    AirlinePricePoint(airline: "GOL Transportes Aéreos", rating: 0.65, seatClass: .first,          pricePerKM: 0.80),
    // Royal Air Maroc (rating 0.7)
    AirlinePricePoint(airline: "Royal Air Maroc",  rating: 0.7,  seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Royal Air Maroc",  rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "Royal Air Maroc",  rating: 0.7,  seatClass: .business,       pricePerKM: 0.71),
    AirlinePricePoint(airline: "Royal Air Maroc",  rating: 0.7,  seatClass: .first,          pricePerKM: 1.28),
    // S7 Airlines (rating 0.75)
    AirlinePricePoint(airline: "S7 Airlines",      rating: 0.75, seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "S7 Airlines",      rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "S7 Airlines",      rating: 0.75, seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "S7 Airlines",      rating: 0.75, seatClass: .first,          pricePerKM: 1.30),
    // Royal Jordanian (rating 0.75)
    AirlinePricePoint(airline: "Royal Jordanian",  rating: 0.75, seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "Royal Jordanian",  rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "Royal Jordanian",  rating: 0.75, seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "Royal Jordanian",  rating: 0.75, seatClass: .first,          pricePerKM: 1.29),
    // Aegean Airlines (rating 0.85)
    AirlinePricePoint(airline: "Aegean Airlines",  rating: 0.85, seatClass: .economy,        pricePerKM: 0.25),
    AirlinePricePoint(airline: "Aegean Airlines",  rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.45),
    AirlinePricePoint(airline: "Aegean Airlines",  rating: 0.85, seatClass: .business,       pricePerKM: 0.82),
    AirlinePricePoint(airline: "Aegean Airlines",  rating: 0.85, seatClass: .first,          pricePerKM: 1.45),
    // Air Serbia (rating 0.7)
    AirlinePricePoint(airline: "Air Serbia",       rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Air Serbia",       rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Air Serbia",       rating: 0.7,  seatClass: .business,       pricePerKM: 0.67),
    AirlinePricePoint(airline: "Air Serbia",       rating: 0.7,  seatClass: .first,          pricePerKM: 1.24),
    // Aerolineas Argentinas (rating 0.65)
    AirlinePricePoint(airline: "Aerolineas Argentinas", rating: 0.65, seatClass: .economy,        pricePerKM: 0.18),
    AirlinePricePoint(airline: "Aerolineas Argentinas", rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Aerolineas Argentinas", rating: 0.65, seatClass: .business,       pricePerKM: 0.60),
    AirlinePricePoint(airline: "Aerolineas Argentinas", rating: 0.65, seatClass: .first,          pricePerKM: 1.15),
    // EgyptAir (rating 0.7)
    AirlinePricePoint(airline: "EgyptAir",         rating: 0.7,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "EgyptAir",         rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "EgyptAir",         rating: 0.7,  seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "EgyptAir",         rating: 0.7,  seatClass: .first,          pricePerKM: 1.30),
    // ITA Airways (rating 0.7)
    AirlinePricePoint(airline: "ITA Airways",      rating: 0.7,  seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "ITA Airways",      rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "ITA Airways",      rating: 0.7,  seatClass: .business,       pricePerKM: 0.72),
    AirlinePricePoint(airline: "ITA Airways",      rating: 0.7,  seatClass: .first,          pricePerKM: 1.33),
    // Volaris (rating 0.6)
    AirlinePricePoint(airline: "Volaris",          rating: 0.6,  seatClass: .economy,        pricePerKM: 0.09),
    AirlinePricePoint(airline: "Volaris",          rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.15),
    AirlinePricePoint(airline: "Volaris",          rating: 0.6,  seatClass: .business,       pricePerKM: 0.31),
    AirlinePricePoint(airline: "Volaris",          rating: 0.6,  seatClass: .first,          pricePerKM: 0.73),
    // Air Transat (rating 0.75)
    AirlinePricePoint(airline: "Air Transat",      rating: 0.75, seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Air Transat",      rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Air Transat",      rating: 0.75, seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "Air Transat",      rating: 0.75, seatClass: .first,          pricePerKM: 1.25),
    // flydubai (rating 0.7)
    AirlinePricePoint(airline: "flydubai",         rating: 0.7,  seatClass: .economy,        pricePerKM: 0.15),
    AirlinePricePoint(airline: "flydubai",         rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.27),
    AirlinePricePoint(airline: "flydubai",         rating: 0.7,  seatClass: .business,       pricePerKM: 0.50),
    AirlinePricePoint(airline: "flydubai",         rating: 0.7,  seatClass: .first,          pricePerKM: 1.00),
    // Air Arabia (rating 0.65)
    AirlinePricePoint(airline: "Air Arabia",       rating: 0.65, seatClass: .economy,        pricePerKM: 0.11),
    AirlinePricePoint(airline: "Air Arabia",       rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "Air Arabia",       rating: 0.65, seatClass: .business,       pricePerKM: 0.37),
    AirlinePricePoint(airline: "Air Arabia",       rating: 0.65, seatClass: .first,          pricePerKM: 0.79),
    // Lion Air (rating 0.6)
    AirlinePricePoint(airline: "Lion Air",         rating: 0.6,  seatClass: .economy,        pricePerKM: 0.10),
    AirlinePricePoint(airline: "Lion Air",         rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.17),
    AirlinePricePoint(airline: "Lion Air",         rating: 0.6,  seatClass: .business,       pricePerKM: 0.34),
    AirlinePricePoint(airline: "Lion Air",         rating: 0.6,  seatClass: .first,          pricePerKM: 0.75),
    // Batik Air (rating 0.65)
    AirlinePricePoint(airline: "Batik Air",        rating: 0.65, seatClass: .economy,        pricePerKM: 0.14),
    AirlinePricePoint(airline: "Batik Air",        rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.25),
    AirlinePricePoint(airline: "Batik Air",        rating: 0.65, seatClass: .business,       pricePerKM: 0.48),
    AirlinePricePoint(airline: "Batik Air",        rating: 0.65, seatClass: .first,          pricePerKM: 0.95),
    // Royal Brunei Airlines (rating 0.85)
    AirlinePricePoint(airline: "Royal Brunei Airlines", rating: 0.85, seatClass: .economy,        pricePerKM: 0.24),
    AirlinePricePoint(airline: "Royal Brunei Airlines", rating: 0.85, seatClass: .premiumEconomy, pricePerKM: 0.43),
    AirlinePricePoint(airline: "Royal Brunei Airlines", rating: 0.85, seatClass: .business,       pricePerKM: 0.80),
    AirlinePricePoint(airline: "Royal Brunei Airlines", rating: 0.85, seatClass: .first,          pricePerKM: 1.46),
    // Jetstar Asia (rating 0.65)
    AirlinePricePoint(airline: "Jetstar Asia",     rating: 0.65, seatClass: .economy,        pricePerKM: 0.11),
    AirlinePricePoint(airline: "Jetstar Asia",     rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.19),
    AirlinePricePoint(airline: "Jetstar Asia",     rating: 0.65, seatClass: .business,       pricePerKM: 0.38),
    AirlinePricePoint(airline: "Jetstar Asia",     rating: 0.65, seatClass: .first,          pricePerKM: 0.82),
    // TAAG Angola Airlines (rating 0.7)
    AirlinePricePoint(airline: "TAAG Angola Airlines", rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "TAAG Angola Airlines", rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "TAAG Angola Airlines", rating: 0.7,  seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "TAAG Angola Airlines", rating: 0.7,  seatClass: .first,          pricePerKM: 1.25),
    // Air Baltic (rating 0.75)
    AirlinePricePoint(airline: "Air Baltic",       rating: 0.75, seatClass: .economy,        pricePerKM: 0.18),
    AirlinePricePoint(airline: "Air Baltic",       rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Air Baltic",       rating: 0.75, seatClass: .business,       pricePerKM: 0.62),
    AirlinePricePoint(airline: "Air Baltic",       rating: 0.75, seatClass: .first,          pricePerKM: 1.18),
    // Luxair (rating 0.75)
    AirlinePricePoint(airline: "Luxair",           rating: 0.75, seatClass: .economy,        pricePerKM: 0.23),
    AirlinePricePoint(airline: "Luxair",           rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.41),
    AirlinePricePoint(airline: "Luxair",           rating: 0.75, seatClass: .business,       pricePerKM: 0.75),
    AirlinePricePoint(airline: "Luxair",           rating: 0.75, seatClass: .first,          pricePerKM: 1.37),
    // TAROM (rating 0.7)
    AirlinePricePoint(airline: "TAROM",            rating: 0.7,  seatClass: .economy,        pricePerKM: 0.21),
    AirlinePricePoint(airline: "TAROM",            rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.38),
    AirlinePricePoint(airline: "TAROM",            rating: 0.7,  seatClass: .business,       pricePerKM: 0.70),
    AirlinePricePoint(airline: "TAROM",            rating: 0.7,  seatClass: .first,          pricePerKM: 1.29),
    // Sky Airline (rating 0.6)
    AirlinePricePoint(airline: "Sky Airline",      rating: 0.6,  seatClass: .economy,        pricePerKM: 0.10),
    AirlinePricePoint(airline: "Sky Airline",      rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.17),
    AirlinePricePoint(airline: "Sky Airline",      rating: 0.6,  seatClass: .business,       pricePerKM: 0.33),
    AirlinePricePoint(airline: "Sky Airline",      rating: 0.6,  seatClass: .first,          pricePerKM: 0.75),
    // JetSMART (rating 0.6)
    AirlinePricePoint(airline: "JetSMART",         rating: 0.6,  seatClass: .economy,        pricePerKM: 0.09),
    AirlinePricePoint(airline: "JetSMART",         rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.15),
    AirlinePricePoint(airline: "JetSMART",         rating: 0.6,  seatClass: .business,       pricePerKM: 0.30),
    AirlinePricePoint(airline: "JetSMART",         rating: 0.6,  seatClass: .first,          pricePerKM: 0.72),
    // Air Tanzania (rating 0.65)
    AirlinePricePoint(airline: "Air Tanzania",     rating: 0.65, seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "Air Tanzania",     rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "Air Tanzania",     rating: 0.65, seatClass: .business,       pricePerKM: 0.63),
    AirlinePricePoint(airline: "Air Tanzania",     rating: 0.65, seatClass: .first,          pricePerKM: 1.19),
    // RwandAir (rating 0.7)
    AirlinePricePoint(airline: "RwandAir",         rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "RwandAir",         rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "RwandAir",         rating: 0.7,  seatClass: .business,       pricePerKM: 0.67),
    AirlinePricePoint(airline: "RwandAir",         rating: 0.7,  seatClass: .first,          pricePerKM: 1.24),
    // Tunisair (rating 0.65)
    AirlinePricePoint(airline: "Tunisair",         rating: 0.65, seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "Tunisair",         rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "Tunisair",         rating: 0.65, seatClass: .business,       pricePerKM: 0.65),
    AirlinePricePoint(airline: "Tunisair",         rating: 0.65, seatClass: .first,          pricePerKM: 1.22),
    // Uzbekistan Airways (rating 0.7)
    AirlinePricePoint(airline: "Uzbekistan Airways", rating: 0.7,  seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "Uzbekistan Airways", rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "Uzbekistan Airways", rating: 0.7,  seatClass: .business,       pricePerKM: 0.65),
    AirlinePricePoint(airline: "Uzbekistan Airways", rating: 0.7,  seatClass: .first,          pricePerKM: 1.20),
    // Air Astana (rating 0.8)
    AirlinePricePoint(airline: "Air Astana",       rating: 0.8,  seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Air Astana",       rating: 0.8,  seatClass: .premiumEconomy, pricePerKM: 0.39),
    AirlinePricePoint(airline: "Air Astana",       rating: 0.8,  seatClass: .business,       pricePerKM: 0.72),
    AirlinePricePoint(airline: "Air Astana",       rating: 0.8,  seatClass: .first,          pricePerKM: 1.35),
    // SriLankan Airlines (rating 0.7)
    AirlinePricePoint(airline: "SriLankan Airlines", rating: 0.7,  seatClass: .economy,        pricePerKM: 0.20),
    AirlinePricePoint(airline: "SriLankan Airlines", rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.36),
    AirlinePricePoint(airline: "SriLankan Airlines", rating: 0.7,  seatClass: .business,       pricePerKM: 0.68),
    AirlinePricePoint(airline: "SriLankan Airlines", rating: 0.7,  seatClass: .first,          pricePerKM: 1.27),
    // Biman Bangladesh (rating 0.6)
    AirlinePricePoint(airline: "Biman Bangladesh", rating: 0.6,  seatClass: .economy,        pricePerKM: 0.18),
    AirlinePricePoint(airline: "Biman Bangladesh", rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.32),
    AirlinePricePoint(airline: "Biman Bangladesh", rating: 0.6,  seatClass: .business,       pricePerKM: 0.60),
    AirlinePricePoint(airline: "Biman Bangladesh", rating: 0.6,  seatClass: .first,          pricePerKM: 1.15),
    // Pakistan Int'l (rating 0.6)
    AirlinePricePoint(airline: "Pakistan Int'l",   rating: 0.6,  seatClass: .economy,        pricePerKM: 0.19),
    AirlinePricePoint(airline: "Pakistan Int'l",   rating: 0.6,  seatClass: .premiumEconomy, pricePerKM: 0.34),
    AirlinePricePoint(airline: "Pakistan Int'l",   rating: 0.6,  seatClass: .business,       pricePerKM: 0.63),
    AirlinePricePoint(airline: "Pakistan Int'l",   rating: 0.6,  seatClass: .first,          pricePerKM: 1.18),
    // SunExpress (rating 0.7)
    AirlinePricePoint(airline: "SunExpress",       rating: 0.7,  seatClass: .economy,        pricePerKM: 0.14),
    AirlinePricePoint(airline: "SunExpress",       rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.25),
    AirlinePricePoint(airline: "SunExpress",       rating: 0.7,  seatClass: .business,       pricePerKM: 0.48),
    AirlinePricePoint(airline: "SunExpress",       rating: 0.7,  seatClass: .first,          pricePerKM: 0.95),
    // Air Malta (rating 0.75)
    AirlinePricePoint(airline: "Air Malta",        rating: 0.75, seatClass: .economy,        pricePerKM: 0.22),
    AirlinePricePoint(airline: "Air Malta",        rating: 0.75, seatClass: .premiumEconomy, pricePerKM: 0.40),
    AirlinePricePoint(airline: "Air Malta",        rating: 0.75, seatClass: .business,       pricePerKM: 0.74),
    AirlinePricePoint(airline: "Air Malta",        rating: 0.75, seatClass: .first,          pricePerKM: 1.36),
    // airasia X (rating 0.65)
    AirlinePricePoint(airline: "airasia X",        rating: 0.65, seatClass: .economy,        pricePerKM: 0.10),
    AirlinePricePoint(airline: "airasia X",        rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.18),
    AirlinePricePoint(airline: "airasia X",        rating: 0.65, seatClass: .business,       pricePerKM: 0.35),
    AirlinePricePoint(airline: "airasia X",        rating: 0.65, seatClass: .first,          pricePerKM: 0.78),
    // Eurowings (rating 0.7)
    AirlinePricePoint(airline: "Eurowings",        rating: 0.7,  seatClass: .economy,        pricePerKM: 0.15),
    AirlinePricePoint(airline: "Eurowings",        rating: 0.7,  seatClass: .premiumEconomy, pricePerKM: 0.27),
    AirlinePricePoint(airline: "Eurowings",        rating: 0.7,  seatClass: .business,       pricePerKM: 0.52),
    AirlinePricePoint(airline: "Eurowings",        rating: 0.7,  seatClass: .first,          pricePerKM: 1.05),
    // Flynas (rating 0.65)
    AirlinePricePoint(airline: "Flynas",           rating: 0.65, seatClass: .economy,        pricePerKM: 0.12),
    AirlinePricePoint(airline: "Flynas",           rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.21),
    AirlinePricePoint(airline: "Flynas",           rating: 0.65, seatClass: .business,       pricePerKM: 0.40),
    AirlinePricePoint(airline: "Flynas",           rating: 0.65, seatClass: .first,          pricePerKM: 0.83),
    // SalamAir (rating 0.65)
    AirlinePricePoint(airline: "SalamAir",         rating: 0.65, seatClass: .economy,        pricePerKM: 0.12),
    AirlinePricePoint(airline: "SalamAir",         rating: 0.65, seatClass: .premiumEconomy, pricePerKM: 0.20),
    AirlinePricePoint(airline: "SalamAir",         rating: 0.65, seatClass: .business,       pricePerKM: 0.39),
    AirlinePricePoint(airline: "SalamAir",         rating: 0.65, seatClass: .first,          pricePerKM: 0.81)
]

final class PricePredictorModel {
    private var dataset: [AirlinePricePoint]
    private let k: Int
    
    init(dataset: [AirlinePricePoint], k: Int) {
        self.dataset = dataset
        self.k = k
    }
    
    func predictPricePerKM(rating: Double, seatClass: SeatClass) -> Double {
        let classFiltered = dataset.filter { $0.seatClass == seatClass }
        
        guard !classFiltered.isEmpty else { return 0 }
        
        let sorted = classFiltered.sorted { abs($0.rating - rating) < abs($1.rating - rating) }
        
        let nearest = sorted.prefix(k)
        
        let total = nearest.reduce(0) { $0 + $1.pricePerKM }
        return total / Double(nearest.count)
    }
}

/// Change k later to make it more accurate - to be done later after implementing departure and landing logic
let predictorModel = PricePredictorModel(dataset: airlinePricePoints, k: 11)
