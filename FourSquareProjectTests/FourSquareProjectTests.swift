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

    func testVenueAPIClient() {
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
}
