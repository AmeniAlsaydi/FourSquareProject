//
//  SavedVenueCell.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/29/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

protocol CellButtonDelegate: AnyObject {
    func didSelectButton(_ cell: SavedVenueCell, venue: Venue)
}

class SavedVenueCell: UICollectionViewCell {
    
    private var currentVenue: Venue!
    
    weak var delegate: CellButtonDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        venueImage.clipsToBounds = true
        venueImage.layer.cornerRadius = 13
    }
    
    public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "tortoise.fill")
        return image
    }()
    public lazy var venueLabel: UILabel = {
        let label = UILabel()
        label.text = "Venue label"
        label.numberOfLines = 0
        return label
    }()
    public lazy var optionsButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        imageConstraints()
        labelConstraints()
        buttonConstraints()
    }
    
    @objc func didPressOptionsButton(_ sender: UIButton) {
        delegate?.didSelectButton(self, venue: currentVenue)
    }
    
    private func imageConstraints() {
        addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            venueImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            venueImage.heightAnchor.constraint(equalTo: venueImage.widthAnchor)
        ])
    }
    private func labelConstraints() {
        addSubview(venueLabel)
        venueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            venueLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 10),
            venueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    private func buttonConstraints() {
        addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            optionsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            optionsButton.heightAnchor.constraint(equalToConstant: 44),
            optionsButton.widthAnchor.constraint(equalTo: optionsButton.heightAnchor)
        ])
    }
    public func configureCell(venue: Venue) {
        venueLabel.text = venue.name
        VenueApiClient.getVenuePhotos(venueID: venue.id) { (result) in
            switch result {
            case .failure:
                print("ew no image")
            case .success(let photos):
                let prefix = photos.first?.prefix ?? ""
                let suffix = photos.first?.suffix ?? ""
                let venuePhotos = "\(prefix)original\(suffix)"
                DispatchQueue.main.async {
                    self.venueImage.getImage(with: venuePhotos, writeTo: .cachesDirectory) { (result) in
                        switch result {
                        case .failure:
                            self.venueImage.image = UIImage(systemName: "tortoise.fill")
                        case .success(let image):
                            DispatchQueue.main.async {
                                self.venueImage.image = image
                            }
                        }
                    }
                }
            }
        }
        
    }
    
}
