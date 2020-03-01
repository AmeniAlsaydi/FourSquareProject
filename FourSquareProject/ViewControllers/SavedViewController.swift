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
    
    private var datapersistence: DataPersistence<Collection>
    
    private var savedView = SavedView()
    
    private var savedVenueCollections = [Collection]() {
        didSet {
            savedView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = savedView
    }
    
    init(_ dataPersistence: DataPersistence<Collection>) {
        self.datapersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.datapersistence.delegate = self
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
        loadCollections()
    }
    
    private func loadCollections() {
        do {
            savedVenueCollections = try datapersistence.loadItems()
        } catch {
            print("could not get collections")
        }
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
        return savedVenueCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = savedView.collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError("could not cast to SavedCell")
        }
        let saved = savedVenueCollections[indexPath.row]
        cell.collectionLabel.text = saved.title
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = savedVenueCollections[indexPath.row]
        
        let savedCollectionVC = SavedCollectionViewController(datapersistence)
        savedCollectionVC.category = category.title
        savedCollectionVC.savedVenues = category.venues
        
        navigationController?.pushViewController(savedCollectionVC, animated: true)
    }
    
    
}
extension SavedViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCollections()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCollections()
    }
    
    
}
