//
//  ListViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    
    private let optionsView = OptionsView()
    private var menuShowing = false
    
    override func loadView() {
        view = optionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTargets()
    }
    
    private func setUpTargets() {
        optionsView.leaveTipButton.addTarget(self, action: #selector(leaveTipButtonPressed(_:)), for: .touchUpInside)
        optionsView.cancelButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.submitButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.addToListButton.addTarget(self, action: #selector(addToListButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc private func leaveTipButtonPressed(_ sender: UIButton) {
        
        optionsView.submitButton.isHidden = false
        optionsView.tipTextfeild.isHidden = false
                
        optionsView.leaveTipButton.backgroundColor = .clear
        optionsView.addToListButton.backgroundColor = .clear
        optionsView.leaveTipButton.setImage(nil, for: .normal)
        optionsView.addToListButton.setImage(nil, for: .normal)
        
        optionsView.addToListLabel.text = ""
        optionsView.leaveTipLabel.text = ""
    }
    
    @objc private func cancelPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToListButtonPressed(_ sender: UIButton) {
        print("addToListButtonPressed")
        
        if menuShowing {
            UIView.animate(withDuration: 0.3) {
                self.optionsView.bottomMenuHeight?.isActive = false
                self.optionsView.bottomMenuHeight = self.optionsView.addToCollectionView.heightAnchor.constraint(equalToConstant: 0)
                self.optionsView.bottomMenuHeight?.isActive = true
                self.optionsView.layoutIfNeeded()

            }
            
        } else {
            UIView.animate(withDuration: 0.3) {
                
                self.optionsView.bottomMenuHeight?.isActive = false
                self.optionsView.bottomMenuHeight = self.optionsView.addToCollectionView.heightAnchor.constraint(equalTo: self.optionsView.heightAnchor, multiplier: 0.3)
                self.optionsView.bottomMenuHeight?.isActive = true
                self.optionsView.layoutIfNeeded()
                
                self.optionsView.labelStack.isHidden = true
                self.optionsView.buttonStack.isHidden = true

            }
            
        }
        menuShowing = !menuShowing
        
        // stack views disappear except the cancel button
        
    }
    

}
