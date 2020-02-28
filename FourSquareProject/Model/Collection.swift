//
//  Collection.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/28/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct Collection: Codable & Equatable {
    let title: String
    let venues: [Venue]
    let image: String //link of first in array
    let id: String
}
