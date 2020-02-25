//
//  FourSquareProjectTests.swift
//  FourSquareProjectTests
//
//  Created by Amy Alsaydi on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import XCTest

@testable import FourSquareProject

class FourSquareProjectTests: XCTestCase {

    func testGetVenueAPIClient() {
        let expectedID = "59e9e7c5cf72a01dab3bcc10"
        let searchQuery = "Target"
        let state = "New York"
        
        let exp = XCTestExpectation(description: "venues found")
        
        VenueApiClient.getVenues(state: state, searchQuery: searchQuery) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("\(appError)")
            case .success(let venues):
                let id = venues.first?.id
                
                XCTAssertEqual(id, expectedID)
                exp.fulfill()
            }
        }
        wait(for:[exp], timeout: 5.0)
    }
    
    func testGetPhotoAPIClient() {
        
        let expectedPrefix = "https://fastly.4sqi.net/img/general/"
        let venueId = "59e9e7c5cf72a01dab3bcc10"
        
        let exp = XCTestExpectation(description: "photos found")
        
        VenueApiClient.getVenuePhotos(venueID: venueId) { (result) in
            switch result {
                case .failure(let appError):
                    XCTFail("\(appError)")
                case .success(let photos):
                    let prefix = photos.first?.prefix
                    
                    XCTAssertEqual(prefix, expectedPrefix)
                    exp.fulfill()
            }
        }
        wait(for:[exp], timeout: 5.0)
    }
    
}
