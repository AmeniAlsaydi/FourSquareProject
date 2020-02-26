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
        label.font = UIFont(name: "Times New Roman", size: 30)
        label.textColor = .systemBlue
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
        
                imageConstraints()
                labelConstraints()
    }
    
    private func imageConstraints(){
        addSubview(venueImage)
        NSLayoutConstraint.activate([
        venueImage.topAnchor.constraint(equalTo: topAnchor, constant: 2),
        venueImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        venueImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        venueImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func labelConstraints(){
        addSubview(venueLabel)
        NSLayoutConstraint.activate([
            venueLabel.topAnchor.constraint(equalTo: venueImage.topAnchor),
            venueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            venueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

}
