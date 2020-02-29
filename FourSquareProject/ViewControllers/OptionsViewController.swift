//
//  ListViewController.swift
//  FourSquareProject
//
//  Created by Amy Alsaydi on 2/21/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import DataPersistence

class OptionsViewController: UIViewController {
    
    private let optionsView = OptionsView()
    private let dataPersistence: DataPersistence<Collection>
    private let venue: Venue
    private var collections = [Collection]()
    
    init(dataPersistence: DataPersistence<Collection>, venue: Venue) {
        self.dataPersistence = dataPersistence
        self.venue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var isAddToCollectionButtonPressed = false
    
    private var keyboardIsVisible = false
    private var originalConstraint: NSLayoutConstraint!
    private var imageViewTopConstraint: NSLayoutConstraint!
    
    override func loadView() {
        view = optionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsView.addToCollectionView.collectionList.dataSource = self
        optionsView.addToCollectionView.collectionList.delegate = self
        registerKeyboardNotifications()
      optionsView.addToCollectionView.collectionList.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
        getCollections()
        let url = FileManager.getPath(with: "savedVenues.plist", for: .documentsDirectory)
        print(url)
        setUpTargets()
        optionsView.addToCollectionView.collectionNameTextField.delegate = self
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterKeyboardNotifications()
    }
  
    private func getCollections() {
        
        do {
            try collections = dataPersistence.loadItems()
        } catch {
            print("issue getting the collection from file manager: \(error)")
        }
    }
    
    private func setUpTargets() {
        optionsView.leaveTipButton.addTarget(self, action: #selector(leaveTipButtonPressed(_:)), for: .touchUpInside)
        optionsView.cancelButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.submitButton.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        optionsView.addToListButton.addTarget(self, action: #selector(addToListButtonPressed(_:)), for: .touchUpInside)
        optionsView.addToCollectionView.addButton.addTarget(self, action: #selector(createCollectionButtonPressed(_:)), for: .touchUpInside)
        optionsView.addToCollectionView.bottomButton.addTarget(self, action: #selector(bottomButton(_:)), for: .touchUpInside)
    }
    
    @objc private func bottomButton(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Cancel" {
            dismiss(animated: true, completion: nil)
        } else if sender.titleLabel?.text == "Done" {
            print("the user has created a new collection with a single venue")
            guard let title =  optionsView.addToCollectionView.collectionNameTextField.text else {
                print("no title")
                return
            }
            let venues = [venue]
            
            VenueApiClient.getVenuePhotos(venueID: venue.id) { (result) in
                switch result {
                case .failure(let appError):
                    print("issue getting image in optionc VC when creating the collection: \(appError)")
                case .success(let photos):
                    let firstPhoto = photos.first
                    let imageLink = "\(firstPhoto?.prefix)original\(firstPhoto?.suffix)"
                    let newCollection = Collection(title: title, venues: venues, image: imageLink, id: self.venue.id)
                }
            }
            
            
            
        }
      
        
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


extension OptionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        collections.count // should be the number of collections persisted.
        
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else {
            fatalError("could not downcast to a SavedCell")
        }
        
        let collection = collections[indexPath.row]
        cell.configureCell(collection: collection)
    
        return cell
    }
}


extension OptionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = optionsView.addToCollectionView.safeAreaLayoutGuide.layoutFrame.size
        
        let itemWidth = maxSize.width * 0.30
        return CGSize(width: itemWidth, height: itemWidth)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // we have an index
        let collectionName = collections[indexPath.row].title
        print(collectionName)
        
        // get venues
        
        var venues = collections[indexPath.row].venues
        venues.append(venue)
        var updatedCollection = collections[indexPath.row]
        updatedCollection.venues = venues
        
        dataPersistence.update(updatedCollection, at: indexPath.row)
        
        
    }

}
