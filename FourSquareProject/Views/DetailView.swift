//
//  DetailView.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .white
        scrollview.frame = self.bounds
        return scrollview
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
       }()
    
    private lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "targetImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.alpha = 0.5
        return iv
    }()
    
    private lazy var venueImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "targetImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Target"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    private lazy var locationIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "mappin.and.ellipse")
        iv.tintColor = .black
        return iv
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        label.text = """
        139 Flatbush Ave (at Atlantic Ave)
        Brooklyn, NY 11217,
        United States
"""
        return label
    }()
    private lazy var venueDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi tellus lorem, pretium ac tellus placerat, maximus tincidunt magna. Maecenas porttitor diam at facilisis ultrices. Pellentesque at accumsan magna, sit amet semper dolor. Sed porttitor blandit eros, quis mattis nunc dictum sed. Integer accumsan accumsan tortor ac ultrices. Nullam imperdiet arcu non lorem luctus vestibulum. Donec ut arcu tellus. In finibus, mauris ut posuere auctor, erat enim vulputit at."
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        scrollViewContraints()
        contentViewContraints()
        backgroundImageContraints()
        venueImageContraints()
        venueNameConstraints()
        locationIconConstraints()
        addressConstraints()
        venueDesConstraints()
    }
    
    private func scrollViewContraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = self.bounds.width
        let height = self.bounds.height

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: width),
            scrollView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func contentViewContraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func backgroundImageContraints() {
        contentView.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
        backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
        backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
        backgroundImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func venueImageContraints() {
        contentView.addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        venueImage.topAnchor.constraint(equalTo: backgroundImage.centerYAnchor, constant: -50),
        venueImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        venueImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90),
        venueImage.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func venueNameConstraints() {
        contentView.addSubview(venueNameLabel)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueNameLabel.topAnchor.constraint(equalTo: venueImage.bottomAnchor, constant: 20),
            venueNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            venueNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)

        ])
    }
    
    private func locationIconConstraints() {
        contentView.addSubview(locationIcon)
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        
          NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 10),
            locationIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            locationIcon.heightAnchor.constraint(equalTo: locationIcon.widthAnchor)
          
          ])
    }
    
    private func addressConstraints() {
           contentView.addSubview(addressLabel)
           addressLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               addressLabel.topAnchor.constraint(equalTo: locationIcon.topAnchor),
               addressLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 10),
               addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
           ])
       }
    
    
    private func venueDesConstraints() {
        contentView.addSubview(venueDescription)
        venueDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueDescription.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            venueDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            venueDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            venueDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

        ])
    }

}


// SCROLL VIEW CONTENTS HAVE TO BE CONSTRAINED TO SCROLL VIEW NOT TO THE CONTENT VIEW - WHY?? IDK
