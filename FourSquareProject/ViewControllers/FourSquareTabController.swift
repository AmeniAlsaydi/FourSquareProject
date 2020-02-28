//
//  FourSquareTabController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/24/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class FourSquareTabController: UITabBarController {
    
    private var datapersistence = DataPersistence<Collection>(filename: "savedVenues.plist")

    private lazy var mapVC: MapViewController = {
       let vc = MapViewController(datapersistence)
        vc.tabBarItem = UITabBarItem(title: "Find", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    
    private lazy var savedVC: SavedViewController = {
       let vc = SavedViewController(datapersistence)
        vc.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "square.and.arrow.down"), tag: 1)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [UINavigationController(rootViewController: mapVC),
        UINavigationController(rootViewController: savedVC)]

    }
    


}
