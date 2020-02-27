//
//  TableViewCell.swift
//  FourSquareProject
//
//  Created by Christian Hurtado on 2/25/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

   public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "tortoise.fill")
        return image
    }()
    public lazy var venueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .systemBlue
        return label
    }()
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = "testing category"
        label.textColor = .systemGray
        return label
    }()
    public lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = "address label is here and it will fit because I made it 0 lines"
        label.textColor = .systemGray
        return label
    }()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
        
}


   required init(coder aDecoder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
    commonInit()

   }
    
    private func commonInit(){
        venueImage.backgroundColor = .systemPink
                venueLabel.text = "venue name here"
                venueImage.translatesAutoresizingMaskIntoConstraints = false
                venueLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
                imageConstraints()
                labelConstraints()
                categoryConstraint()
                addressConstraint()
    }
    
    private func imageConstraints(){
        addSubview(venueImage)
        NSLayoutConstraint.activate([
        venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        venueImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        venueImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func labelConstraints(){
        addSubview(venueLabel)
        NSLayoutConstraint.activate([
            venueLabel.topAnchor.constraint(equalTo: venueImage.topAnchor),
            venueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueLabel.trailingAnchor.constraint(equalTo: venueImage.leadingAnchor, constant: -8)
        ])
    }
    
    private func categoryConstraint(){
        addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: venueLabel.bottomAnchor, constant: 2),
            categoryLabel.leadingAnchor.constraint(equalTo: venueLabel.leadingAnchor)
        ])
    }
    
    private func addressConstraint(){
        addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2),
            addressLabel.leadingAnchor.constraint(equalTo: venueLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: venueImage.leadingAnchor, constant: -8)
        ])
    }
    
    public func configureTableViewCell(venue: Venue) {
        venueLabel.text = venue.name
        addressLabel.text = venue.location.address
        categoryLabel.text = "\(venue.categories[0].name)"
       
        VenueApiClient.getVenuePhotos(venueID: venue.id) { (result) in
            switch result {
            case .failure:
                print("ew no image")
            case .success(let photos):
                let prefix = photos.first?.prefix ?? ""
                let suffix = photos.first?.suffix ?? ""
                let venuePhotos = "\(prefix)original\(suffix)"
                DispatchQueue.main.async {
                    self.venueImage.getImage(with: venuePhotos) { (result) in
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
