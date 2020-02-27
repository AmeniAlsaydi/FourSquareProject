//
//  DetailViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class DetailViewController: UIViewController {

    private var datapersistance: DataPersistence<Venue>
    private var venue: Venue
    private var photo: Photo

    private let detailView = DetailView()
    
    init(_ dataPersistance: DataPersistence<Venue>, venue: Venue, photo: Photo) {
        self.datapersistance = dataPersistance
        self.venue = venue
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) - error")
    }

    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(moreButtonPressed(_:)))
    }
    
    @objc private func moreButtonPressed(_ sender: UIBarButtonItem) {
        print("Bar button pressed")
    }

}
