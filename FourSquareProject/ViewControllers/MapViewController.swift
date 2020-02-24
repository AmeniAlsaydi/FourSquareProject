//
//  MapViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class MapViewController: UIViewController {
    
    private var datapersistance: DataPersistence<Venue>
    
    private var mapView = MapView()
    
    init(_ dataPersistance: DataPersistence<Venue>) {
        self.datapersistance = dataPersistance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) - error")
    }
    
    override func loadView() {
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search Venue"

        //collectionView
        mapView.collectionView.register(MapViewCell.self, forCellWithReuseIdentifier: "mapViewCell")
        mapView.collectionView.dataSource = self
        mapView.collectionView.delegate = self
        
    }
    
    

}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mapView.collectionView.dequeueReusableCell(withReuseIdentifier: "mapViewCell", for: indexPath) as? MapViewCell else {
            fatalError("could not cast to mapViewCell")
        }
        cell.backgroundColor = .white
        return cell
    }
}
extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
