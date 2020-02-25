//
//  Photo.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct PhotoSearch: Codable & Equatable {
     let response: PhotoResponse
}

struct PhotoResponse: Codable & Equatable {
    let photos: Photos
}

struct Photos: Codable & Equatable {
    let items: [Photo]
}

struct Photo: Codable & Equatable { // photo info
    let prefix: String
    let suffix: String
}
