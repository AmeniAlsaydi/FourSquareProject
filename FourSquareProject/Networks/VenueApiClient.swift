//
//  VenueApiClient.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import NetworkHelper


struct VenueApiClient {
    
    static func getVenues(state: String, searchQuery: String, completeion: @escaping (Result<[Venue], AppError>) -> ()) {
       
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "target"
        let state = state.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "miami"
        
        let endpoint = "https://api.foursquare.com/v2/venues/search?client_id=\(Config.clientID)&client_secret=\(Config.clientSecret)&near=\(state)&query=\(searchQuery)&v=20211010&limit=1"
         
        
        guard let url = URL(string: endpoint) else {
            completeion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completeion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let search = try JSONDecoder().decode(VenueSearch.self, from: data)
                    completeion(.success(search.response.venues))
                } catch {
                    completeion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getVenuePhotos(venueID: String, completeion: @escaping (Result<[Photo], AppError>) -> ()) {
        let endpoint = "https://api.foursquare.com/v2/venues/\(venueID)/photos?client_id=\(Config.clientID)&client_secret=\(Config.clientSecret)&v=20211010&limit=1"
        
        
        guard let url = URL(string: endpoint) else {
            completeion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request, maxCacheDays: 2) { (result) in
            switch result {
            case .failure(let appError):
                completeion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let photoSearch = try JSONDecoder().decode(PhotoSearch.self, from: data)
                    completeion(.success(photoSearch.response.photos.items))
                } catch {
                    completeion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
