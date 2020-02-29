//
//  AddToCollectionView.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/28/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class AddToCollectionView: UIView {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Save to"
        label.textAlignment = .center
        return label
    }()
    
    public lazy var addButton: UIButton = {
           let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
           return button
       }()

    public lazy var collectionList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    

    public lazy var bottomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Cancel", for: .normal)
        return button
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
        
        constrainTopLabel()
        constrainAddButton() 
        constrainCV()
        constrainBottomButton()
    }

    private func constrainTopLabel() {
        addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func constrainAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalTo: topLabel.heightAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func constrainCV() {
           addSubview(collectionList)
           collectionList.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
            collectionList.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionList.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionList.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
            collectionList.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55)
           ])
       }
    
    private func constrainBottomButton() {
        addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bottomButton.topAnchor.constraint(equalTo: collectionList.bottomAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            //bottomButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}
