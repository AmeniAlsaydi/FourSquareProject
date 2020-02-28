//
//  DetailViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit
import MapKit

class DetailViewController: UIViewController {
    
    private var datapersistance: DataPersistence<Collection>
    private var venue: Venue
    private var photoID: String
    
    private let detailView = DetailView()
    private var locationSession = CoreLocationSession()
    
    init(_ dataPersistance: DataPersistence<Collection>, venue: Venue, photoID: String) {
        self.datapersistance = dataPersistance
        self.venue = venue
        self.photoID = photoID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) - error")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(moreButtonPressed(_:)))
        
        updateUI()
    }
    
    @objc private func moreButtonPressed(_ sender: UIBarButtonItem) {
        print("Bar button pressed")
        
        let optionsVC = OptionsViewController()
        optionsVC.modalPresentationStyle = .overFullScreen
        present(optionsVC, animated: true)
    }
    
    private func loadVenueAnnoatation(venue: Venue) {
        let annotation = MKPointAnnotation()
        annotation.title = venue.name
        let lat = venue.location.lat
        let lng = venue.location.lng
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: lng)
        detailView.mapKitView.addAnnotations([annotation])
        detailView.mapKitView.showAnnotations([annotation], animated: true)
        
    }
    
    private func updateUI() {
        // venue name
        detailView.venueNameLabel.text = venue.name
        
        // venue address
        let address = "\(venue.location.formattedAddress[0]) \n\(venue.location.formattedAddress[1]) \n\(venue.location.formattedAddress[2])"
        detailView.addressLabel.text = address
        
        // venue categories
        detailView.categoryLabel.text = venue.categories.first?.name
        guard let iconPrefix = venue.categories.first?.icon.prefix, let iconSuffix = venue.categories.first?.icon.suffix else {
            return 
        }
        let iconUrl = "\(iconPrefix)64\(iconSuffix)"
        
        detailView.categoryIcon.getImage(with: iconUrl) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("issue getting category icon: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.categoryIcon.image = image
                }
            }
        }
        
        // venue photo
        
        VenueApiClient.getVenuePhotos(venueID: photoID) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let photos):
                //
                guard let prefix = photos.first?.prefix, let suffix = photos.first?.suffix else {
                    print("no prefix or suffix for image")
                    return
                }
                let imageUrl = "\(prefix)original\(suffix)"
                DispatchQueue.main.async {
                    self.detailView.backgroundImage.getImage(with: imageUrl) { (result) in
                        switch result {
                        case .failure(let appError):
                            DispatchQueue.main.async {
                                self.detailView.backgroundImage.image = UIImage(systemName: "folder")
                            }
                            print("error with loading venue photo \(appError)")
                        case .success(let image):
                            DispatchQueue.main.async {
                                self.detailView.backgroundImage.image = image
                                self.detailView.venueImage.image = image
                            }
                        }
                    }
                }
            }
        }
        
        // venue annotation on map
        
        loadVenueAnnoatation(venue: venue)
    }
    
}
