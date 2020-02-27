//
//  DetailView.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/25/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import MapKit

class DetailView: UIView {
    
    public lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .clear
        return scrollview
    }()
    
    public lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
       }()
    
    public lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "targetImage")
        iv.clipsToBounds = true
        iv.alpha = 1
        return iv
    }()
    
    
    public lazy var blur: UIVisualEffectView = {
       let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
       return blur
    }()
    
    public lazy var venueImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "targetImage")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    public lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Target"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    public lazy var locationIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "mappin.and.ellipse")
        iv.tintColor = .black
        return iv
    }()
    
    public lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        label.text = "No Address"
        return label
    }()
    
    public lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    public lazy var categoryIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "mappin.and.ellipse")
        iv.tintColor = .black
        return iv
    }()
    
    public lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        label.text = """
        No Category
        blah blah blah
"""
        return label
    }()
    
    public lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    public lazy var mapKitView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    public lazy var venueDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
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
        blurContraints()
        venueImageContraints()
        venueNameConstraints()
        locationIconConstraints()
        addressConstraints()
        categorytitleConstraints()
        categoryIconConstraints()
        cateoryConstraints()
        locationTitleConstraints()
        
        mapConstraints()
        
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
            //scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    
    private func blurContraints() {
        
        backgroundImage.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        blur.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
        blur.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
        blur.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
        blur.heightAnchor.constraint(equalTo: backgroundImage.heightAnchor)
        ])
    }
    
    private func venueImageContraints() {
        contentView.addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        venueImage.topAnchor.constraint(equalTo: backgroundImage.centerYAnchor, constant: -70),
        venueImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        venueImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.90),
        venueImage.heightAnchor.constraint(equalToConstant: 200)
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
    
    private func categorytitleConstraints() {
        contentView.addSubview(categoryTitleLabel)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryTitleLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func categoryIconConstraints() {
        contentView.addSubview(categoryIcon)
        categoryIcon.translatesAutoresizingMaskIntoConstraints = false
        
          NSLayoutConstraint.activate([
            categoryIcon.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 10),
            categoryIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            categoryIcon.widthAnchor.constraint(equalToConstant: 20),
            categoryIcon.heightAnchor.constraint(equalTo: categoryIcon.widthAnchor)
          
          ])
    }
    
    private func cateoryConstraints() {
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: categoryIcon.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryIcon.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func locationTitleConstraints() {
        contentView.addSubview(locationTitleLabel)
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        locationTitleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
        locationTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        locationTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func mapConstraints(){
        contentView.addSubview(mapKitView)
        mapKitView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapKitView.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 20),
            mapKitView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20),
            mapKitView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapKitView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    private func venueDesConstraints() {
        contentView.addSubview(venueDescription)
        venueDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueDescription.topAnchor.constraint(equalTo: mapKitView.bottomAnchor, constant: 20),
            venueDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            venueDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            venueDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

        ])
    }
}

