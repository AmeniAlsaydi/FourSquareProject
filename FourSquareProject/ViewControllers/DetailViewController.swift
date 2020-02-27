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

class DetailViewController: UIViewController {
    
    private var datapersistance: DataPersistence<Venue>
    private var venue: Venue
    private var photo: Photo
    
    private let detailView = DetailView()
    
    init(_ dataPersistance: DataPersistence<Venue>, venue: Venue, photo: Photo) {
        self.datapersistance = dataPersistance
        self.venue = venue
        self.photo = photo
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
    }
    
    
    private func updateUI() {
        
        detailView.venueNameLabel.text = venue.name
        
        let address = "\(venue.location.formattedAddress[0]) \n\(venue.location.formattedAddress[1]) \n\(venue.location.formattedAddress[2])"
        
        detailView.addressLabel.text = address
        
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
        
        let prefix = photo.prefix
        let suffix = photo.suffix
        let imageUrl = "\(prefix)original\(suffix)"
        
        detailView.backgroundImage.getImage(with: imageUrl) { (result) in
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
