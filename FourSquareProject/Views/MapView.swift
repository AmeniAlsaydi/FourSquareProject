//
//  MapView.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {

    public lazy var venueTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.backgroundColor = .white
        textField.placeholder = "search by venue"
        return textField
    }()
    public lazy var locationTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .line
        textField.backgroundColor = .white
        textField.placeholder = "search by location"
        return textField
    }()
    public lazy var mapKitView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return cv
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
        mapConstraints()
        venueTextConstraints()
        locationTextConstraints()
        collectionViewConstraints()
    }
    
    private func mapConstraints(){
        addSubview(mapKitView)
        mapKitView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapKitView.topAnchor.constraint(equalTo: topAnchor),
            mapKitView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapKitView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapKitView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func venueTextConstraints() {
        addSubview(venueTextField)
        venueTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            venueTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            venueTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            venueTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func locationTextConstraints() {
        addSubview(locationTextField)
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: venueTextField.bottomAnchor, constant: 8),
            locationTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            locationTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: mapKitView.heightAnchor , multiplier: 0.2)
        ])
    }
    
}
