//
//  SavedCollectionViewController.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/27/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class SavedCollectionViewController: UIViewController {
    
    private var savedColletionView = SavedCollectionView()
    
    public var category: String?
    
    private var savedVenues = [Venue]()
    
    override func loadView() {
        view = savedColletionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = "\(category ?? "")"
        savedColletionView.backgroundColor = .systemBackground
        
        savedColletionView.collectionView.delegate = self
        savedColletionView.collectionView.dataSource = self
        savedColletionView.collectionView.register(MapViewCell.self, forCellWithReuseIdentifier: "mapViewCell")
    }
    
}
extension SavedCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
extension SavedCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedVenues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = savedColletionView.collectionView.dequeueReusableCell(withReuseIdentifier: "mapViewCell", for: indexPath) as? MapViewCell else {
            fatalError("could not cast to cell")
        }
        let saved = savedVenues[indexPath.row]
        cell.configureCell(venue: saved)
        return cell
    }
    
    
}
