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
        label.text = "Venue label"
        return label
    }()
    
   
    override func awakeFromNib() {
    super.awakeFromNib()
        
        venueImage.backgroundColor = .systemPink
        venueLabel.text = "venue name here"
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        venueLabel.translatesAutoresizingMaskIntoConstraints = false
    
        imageConstraints()
        labelConstraints()
    }
    
    private func imageConstraints(){
        addSubview(venueImage)
        NSLayoutConstraint.activate([
        venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        venueImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func labelConstraints(){
        addSubview(venueLabel)
        NSLayoutConstraint.activate([
            venueLabel.topAnchor.constraint(equalTo: venueImage.topAnchor),
            venueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

}
