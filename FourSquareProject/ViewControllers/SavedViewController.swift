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
       
       // intializer
       
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

    }

}
