//
//  SavedCell.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/27/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import ImageKit

class SavedCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
    }
    
    public lazy var collectionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        return label
    }()
    public lazy var collectionImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        return image
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
    
    public func configureCell(collection: Collection) {
        
        collectionLabel.text = collection.title
        
        if collection.venues.isEmpty {
            collectionImage.image = UIImage(systemName: "plus")
        } else {
            collectionImage.getImage(with: collection.image) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print("issue loading collection image: \(appError)")
                case .success(let image):
                    self?.collectionImage.image = image
                }
            }
        }
    }
    
    private func imageConstraints() {
        addSubview(collectionImage)
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: topAnchor),
            collectionImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        ])
    }
    private func labelConstraints() {
        addSubview(collectionLabel)
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 10),
            collectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
}
