//
//  EmptyView.swift
//  FourSquareProject
//
//  Created by Christian Hurtado on 2/26/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    public lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "No results to show yet."
        return label
    }()
    
    public lazy var messageLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Please search for venues in the map!"
        return label
    }()
    
    
    init(title: String, message: String) {
        super.init(frame: UIScreen.main.bounds)
        titleLabel.text = title
        messageLabel.text = message
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        titleLabelConstraints()
        messageConstraints()
    }
    
    private func titleLabelConstraints() {
           addSubview(titleLabel)
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
               titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
               titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
               titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
           ])
       }

    private func messageConstraints() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
   
}
