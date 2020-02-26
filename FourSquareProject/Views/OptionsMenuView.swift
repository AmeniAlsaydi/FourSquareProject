//
//  OptionsMenuView.swift
//  FourSquareProject
//
//  Created by casandra grullon on 2/26/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class OptionsMenuView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        leaveTipButton.clipsToBounds = true
        leaveTipButton.layer.cornerRadius = 13
        addToListButton.clipsToBounds = true
        addToListButton.layer.cornerRadius = 13
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 13
    }
    
    public lazy var blurEffect: UIBlurEffect = {
       let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
        return blur
    }()
    
    public lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leaveTipButton, addToListButton, cancelButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    public lazy var leaveTipButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus.bubble.fill"), for: .normal)
        return button
    }()
    public lazy var addToListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "text.badge.plus"), for: .normal)
        return button
    }()
    public lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        return button
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
        buttonStackConstraint()
    }
    private func configureBlur() {
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    private func buttonStackConstraint() {
        addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            buttonStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            buttonStack.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

}
