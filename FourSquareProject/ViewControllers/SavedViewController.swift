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
    
    private var savedVenues = [String]()
    
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
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Saved Venues"
        savedView.collectionView.dataSource = self
        savedView.collectionView.delegate = self
        savedView.collectionView.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
    }
    
    
}
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let maxsize: CGSize = UIScreen.main.bounds.size
           let itemWidth: CGFloat = maxsize.width
           let itemHeight: CGFloat = maxsize.height * 0.20
           return CGSize(width: itemWidth, height: itemHeight)
       }
}
extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = savedView.collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError("could not cast to SavedCell")
        }
        let saved = savedVenues[indexPath.row]
        cell.collectionLabel.text = saved
        
        return cell
    }
    
    
}
