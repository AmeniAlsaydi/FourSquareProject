//
//  SavedViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class SavedViewController: UIViewController {
    private var datapersistance: DataPersistence<Venue>
    
    private var savedView = SavedView()
    
    private var savedVenueCategories = ["Favorite Places", "test"] {
        didSet {
            savedView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = savedView
    }
    
    init(_ dataPersistance: DataPersistence<Venue>) {
        self.datapersistance = dataPersistance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) - error")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedView.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Saved Venues"
        savedView.collectionView.dataSource = self
        savedView.collectionView.delegate = self
        savedView.collectionView.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
    }
    
    
}
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let maxSize: CGFloat = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 2
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxSize - totalSpace) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedVenueCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = savedView.collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError("could not cast to SavedCell")
        }
        let saved = savedVenueCategories[indexPath.row]
        cell.collectionLabel.text = saved
        
        cell.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        return cell
    }
    
    
}
