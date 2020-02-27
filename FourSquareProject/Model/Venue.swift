//
//  Venue.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation


struct VenueSearch: Codable & Equatable {
    let response: Response
}

struct Response: Codable & Equatable {
    let venues: [Venue]
}

struct Venue: Codable & Equatable  {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]
}

struct Location: Codable & Equatable{
    let address: String?
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]
}


struct Category: Codable & Equatable {
    let name: String
    let icon: Icon
}

struct Icon: Codable & Equatable {
    let prefix: String
    let suffix: String 
}
 
