//
//  MapViewCell.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class MapViewCell: UICollectionViewCell {
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
    public lazy var venueName: UILabel = {
        let label = UILabel()
        label.text = "venue label"
        return label
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
    }
    private func imageConstraints() {
        addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            venueImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    private func labelConstraints() {
        addSubview(venueName)
        venueName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueName.topAnchor.constraint(equalTo: venueImage.topAnchor),
            venueName.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 8),
            venueName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
}
