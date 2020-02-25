//
//  ListView.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ListView: UIView {

    public lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        tableViewConstraints()
    }
    
    private func tableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
     NSLayoutConstraint.activate([
         tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
     ])
    }
   
}
