//
//  SavedCollectionViewController.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/27/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class SavedCollectionViewController: UIViewController {
    private var datapersistence: DataPersistence<Collection>
    
    private var savedColletionView = SavedCollectionView()
    
    public var category: String?
    
    public var savedVenues = [Venue]() {
        didSet {
            DispatchQueue.main.async {
                self.savedColletionView.collectionView.reloadData()
            }
        }
    }
    
    init(_ dataPersistence: DataPersistence<Collection>) {
        self.datapersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) - error")
    }
    
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
        savedColletionView.collectionView.register(SavedVenueCell.self, forCellWithReuseIdentifier: "savedVenueCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadSavedVenues()
    }
    
    private func loadSavedVenues() {
        do {
            savedVenues = try ((datapersistence.loadItems().filter {$0.title == category}).first?.venues ?? [Venue]())
        } catch {
            print("could not get venues")
        }
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
        guard let cell = savedColletionView.collectionView.dequeueReusableCell(withReuseIdentifier: "savedVenueCell", for: indexPath) as? SavedVenueCell else {
            fatalError("could not cast to cell")
        }
        let saved = savedVenues[indexPath.row]
        cell.configureCell(venue: saved)
        cell.currentVenue = saved
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venue = savedVenues[indexPath.row]
        let detailVC = DetailViewController(datapersistence, venue: venue, photoID: venue.id)
        present(detailVC, animated: true)
    }
    
    
}
extension SavedCollectionViewController: CellButtonDelegate {
    func didSelectButton(_ cell: SavedVenueCell, venue: Venue) {
        showMenu(for: cell)
    }
    private func showMenu(for cell: SavedVenueCell) {
        guard let indexPath = savedColletionView.collectionView.indexPath(for: cell) else {
            return
        }
        let optionsMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            do{
                try self?.datapersistence.deleteItem(at: indexPath.row)
                self?.savedColletionView.collectionView.reloadData()
                self?.loadSavedVenues()
            }catch{
                print("could not delete")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] (action) in
            self?.dismiss(animated: true)
        }
        optionsMenu.addAction(delete)
        optionsMenu.addAction(cancel)
        present(optionsMenu, animated: true, completion: nil)
    }
}
