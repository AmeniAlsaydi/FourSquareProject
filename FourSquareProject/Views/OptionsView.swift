//
//  OptionsMenuView.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/26/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class OptionsView: UIView {

      override func layoutSubviews() {
          super.layoutSubviews()
          leaveTipButton.clipsToBounds = true
          leaveTipButton.layer.cornerRadius = leaveTipButton.frame.width/2
          addToListButton.clipsToBounds = true
          addToListButton.layer.cornerRadius = addToListButton.frame.width/2
          cancelButton.clipsToBounds = true
          cancelButton.layer.cornerRadius = cancelButton.frame.width/2
      }
      
      public lazy var blurEffect: UIBlurEffect = {
          let blur = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterialLight)
          return blur
      }()
      
      public lazy var buttonStack: UIStackView = {
          let stack = UIStackView(arrangedSubviews: [leaveTipButton, addToListButton, cancelButton])
          stack.axis = .vertical
          stack.alignment = .fill
          stack.distribution = .fillEqually
          stack.spacing = 20
          return stack
      }()
      
      
      public lazy var leaveTipButton: UIButton = {
          let button = UIButton()
         // button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
          button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
          button.tintColor = .white
          button.setImage(UIImage(systemName: "plus.bubble.fill"), for: .normal)
          return button
      }()
      public lazy var addToListButton: UIButton = {
          let button = UIButton()
          //button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
          button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
          button.tintColor = .white
          button.setImage(UIImage(systemName: "text.badge.plus"), for: .normal)
          return button
      }()
      public lazy var cancelButton: UIButton = {
          let button = UIButton()
          button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
          button.tintColor = .white
          button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
          return button
      }()
      
      public lazy var leaveTipLabel: UILabel = {
          let label = UILabel()
          label.text = "Leave a Tip"
          label.textAlignment = .right
          label.font = UIFont.systemFont(ofSize: 13, weight: .light)
          return label
      }()
      
      public lazy var addToListLabel: UILabel = {
          let label = UILabel()
          label.text = "Add to List"
          label.textAlignment = .right
          label.font = UIFont.systemFont(ofSize: 13, weight: .light)
          return label
      }()
      
      public lazy var cancelLabel: UILabel = {
          let label = UILabel()
          label.text = "Cancel"
          label.textAlignment = .right
          label.font = UIFont.systemFont(ofSize: 13, weight: .light)
          return label
      }()
      
      public lazy var labelStack: UIStackView = {
          let stack = UIStackView(arrangedSubviews: [leaveTipLabel, addToListLabel, cancelLabel])
          stack.axis = .vertical
          stack.alignment = .fill
          stack.distribution = .fillEqually
          stack.backgroundColor = .blue
          stack.spacing = 20
          return stack
      }()
      
      public lazy var tipTextfeild: UITextField = {
          let tf = UITextField()
          tf.backgroundColor = .tertiarySystemBackground
          tf.layer.cornerRadius = 15
          tf.contentVerticalAlignment = .top
          
          tf.isHidden = true
          tf.placeholder = "Tell us about your experience."
          return tf
      }()
      
      public lazy var submitButton: UIButton = {
          let button = UIButton()
          button.setTitle("Submit Tip", for: .normal)
          button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
          button.backgroundColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
          button.layer.cornerRadius = 10
          button.isHidden = true
          return button
      }()
      
      
      // add list view
      public lazy var createButton: UIButton = {
          let button = UIButton()
          button.setTitle("Create New Collection", for: .normal)
          button.backgroundColor = .black
          return button
      }()
      
      public lazy var collectionList: UICollectionView = {
          let cv = UICollectionView()
          cv.backgroundColor = .black
          return cv
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
          configureBlur()
          textfeildConstraints()
          submitTipConstraints()
          
          //constrainCreateButton()
          //constrainCV()
          
          buttonStackConstraint()
          labelsStackConstraint()
      }
      
      private func configureBlur() {
          let blurEffectView = UIVisualEffectView(effect: blurEffect)
          blurEffectView.frame = self.bounds
          blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          self.addSubview(blurEffectView)
      }
      
      private func textfeildConstraints() {
          addSubview(tipTextfeild)
          tipTextfeild.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              tipTextfeild.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
              tipTextfeild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
              tipTextfeild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
              tipTextfeild.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20)
          ])
          
      }
      
      private func submitTipConstraints() {
          addSubview(submitButton)
          submitButton.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              submitButton.topAnchor.constraint(equalTo: tipTextfeild.bottomAnchor, constant: 20),
              submitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25), //
              submitButton.centerXAnchor.constraint(equalTo: centerXAnchor)
              
          ])
      }
      
      private func buttonStackConstraint() {
          addSubview(buttonStack)
          buttonStack.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
              buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
              buttonStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
              buttonStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
          ])
      }
      
      private func labelsStackConstraint() {
          addSubview(labelStack)
          labelStack.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              labelStack.trailingAnchor.constraint(equalTo: buttonStack.leadingAnchor, constant: -10),
              labelStack.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor),
              labelStack.heightAnchor.constraint(equalTo: buttonStack.heightAnchor),
              labelStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
          ])
          
      }
      
      

}
