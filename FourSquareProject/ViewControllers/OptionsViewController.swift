//
//  ListViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class OptionsViewController: UIViewController {
    
    private let optionsView = OptionsView()
    private let dataPersistence: DataPersistence<Collection>
    private let venue: Venue
    private var collections = [Collection]()
    
    init(dataPersistence: DataPersistence<Collection>, venue: Venue) {
        self.dataPersistence = dataPersistence
        self.venue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = optionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsView.addToCollectionView.collectionList.dataSource = self
        optionsView.addToCollectionView.collectionList.delegate = self
        
        optionsView.addToCollectionView.collectionList.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
        setUpTargets()
        getCollections()
        let url = FileManager.getPath(with: "savedVenues.plist", for: .documentsDirectory)
        print(url)
    }
    
    private func getCollections() {
        
        do {
            try collections = dataPersistence.loadItems()
        } catch {
            print("issue getting the collection from file manager: \(error)")
        }
        
    }
    
    private func setUpTargets() {
        optionsView.leaveTipButton.addTarget(self, action: #selector(leaveTipButtonPressed(_:)), for: .touchUpInside)
        optionsView.cancelButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.submitButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.addToListButton.addTarget(self, action: #selector(addToListButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func leaveTipButtonPressed(_ sender: UIButton) {
        
        optionsView.submitButton.isHidden = false
        optionsView.tipTextfeild.isHidden = false
                
        optionsView.leaveTipButton.backgroundColor = .clear
        optionsView.addToListButton.backgroundColor = .clear
        optionsView.leaveTipButton.setImage(nil, for: .normal)
        optionsView.addToListButton.setImage(nil, for: .normal)
        
        optionsView.addToListLabel.text = ""
        optionsView.leaveTipLabel.text = ""
    }
    
    @objc private func cancelPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToListButtonPressed(_ sender: UIButton) {
        print("addToListButtonPressed")
        
        UIView.animate(withDuration: 0.3) {
        
        self.optionsView.bottomMenuHeight?.isActive = false
        self.optionsView.bottomMenuHeight = self.optionsView.addToCollectionView.heightAnchor.constraint(equalTo: self.optionsView.heightAnchor, multiplier: 0.3)
        self.optionsView.bottomMenuHeight?.isActive = true
        self.optionsView.layoutIfNeeded()
        
        self.optionsView.labelStack.isHidden = true
        self.optionsView.buttonStack.isHidden = true

        }
    }
}


extension OptionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        collections.count // should be the number of collections persisted.
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError("could not downcast to a SavedCell")
        }
        
        let collection = collections[indexPath.row]
        cell.configureCell(collection: collection)
    
        return cell
    }
}


extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = optionsView.addToCollectionView.safeAreaLayoutGuide.layoutFrame.size
        
        let itemWidth = maxSize.width * 0.30
        return CGSize(width: itemWidth, height: itemWidth)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // we have an index
        let collectionName = collections[indexPath.row].title
        print(collectionName)
        
        // get venues
        
        var venues = collections[indexPath.row].venues
        venues.append(venue)
        var updatedCollection = collections[indexPath.row]
        updatedCollection.venues = venues
        
        dataPersistence.update(updatedCollection, at: indexPath.row)
        
        
    }
}
