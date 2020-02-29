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
    
    private var isAddToCollectionButtonPressed = false
    
    private var keyboardIsVisible = false
    private var originalConstraint: NSLayoutConstraint!
    private var imageViewTopConstraint: NSLayoutConstraint!
    
    override func loadView() {
        view = optionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()
        setUpTargets()
        optionsView.addToCollectionView.collectionNameTextField.delegate = self
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterKeyboardNotifications()
    }
    
    private func setUpTargets() {
        optionsView.leaveTipButton.addTarget(self, action: #selector(leaveTipButtonPressed(_:)), for: .touchUpInside)
        optionsView.cancelButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.submitButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.addToListButton.addTarget(self, action: #selector(addToListButtonPressed(_:)), for: .touchUpInside)
        optionsView.addToCollectionView.addButton.addTarget(self, action: #selector(createCollectionButtonPressed(_:)), for: .touchUpInside)
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
        
        UIView.animate(withDuration: 0.3) {
            
            self.optionsView.bottomMenuHeight?.isActive = false
            self.optionsView.bottomMenuHeight = self.optionsView.addToCollectionView.heightAnchor.constraint(equalTo: self.optionsView.heightAnchor, multiplier: 0.3)
            self.optionsView.bottomMenuHeight?.isActive = true
            self.optionsView.layoutIfNeeded()
            
            self.optionsView.labelStack.isHidden = true
            self.optionsView.buttonStack.isHidden = true
            
        }
        
    }
    
    @objc private func createCollectionButtonPressed(_ sender: UIButton) {
        optionsView.addToCollectionView.topLabel.text = "New Collection"
        optionsView.addToCollectionView.collectionList.isHidden = true
        optionsView.addToCollectionView.addButton.isHidden = true
        optionsView.addToCollectionView.collectionImage.isHidden = false
        optionsView.addToCollectionView.collectionNameTextField.isHidden = false
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        moveKeyboardUp(keyboardFrame.size.height)
    }
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        optionsView.bottomMenuTop?.isActive = true
        optionsView.bottomMenuHeight?.isActive = false
        
        originalConstraint = optionsView.bottomMenuHeight
        imageViewTopConstraint = optionsView.bottomMenuTop
        
        imageViewTopConstraint.constant -= height / 3
        
         UIView.animate(withDuration: 0.3) {
             self.view.layoutIfNeeded()
         }
         keyboardIsVisible = true
     }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        resetUI()
    }
    private func resetUI() {
        keyboardIsVisible = false
        optionsView.bottomMenuTop?.constant = 0
        optionsView.bottomMenuTop?.isActive = false
        optionsView.bottomMenuHeight?.isActive = true
        
        imageViewTopConstraint = originalConstraint
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
extension OptionsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        keyboardIsVisible = false
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isSelected {
          keyboardIsVisible = true
        } else {
            keyboardIsVisible = false
        }
        
        if string.isEmpty {
            optionsView.addToCollectionView.bottomButton.setTitle("Cancel", for: .normal)
            optionsView.addToCollectionView.bottomButton.setTitleColor(.black, for: .normal)
        optionsView.addToCollectionView.bottomButton.backgroundColor = .white
        } else {
            optionsView.addToCollectionView.bottomButton.setTitle("Done", for: .normal)
            optionsView.addToCollectionView.bottomButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            optionsView.addToCollectionView.bottomButton.setTitleColor(.white, for: .normal)
        }
        return true
    }
    
}
