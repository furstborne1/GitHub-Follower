//
//  GFArlertVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/17/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView  = UIView()
    let titleForArlert = GFTitle(textAlignment: .center, fontSize: 20)
    let message        = GFBodyLabel(textAlignment: .center)
    let actionButton   = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var messageLabel: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String, messageLabel: String, buttonLabel: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.messageLabel = messageLabel
        self.buttonTitle = buttonLabel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        configureUI()
    }
    
    func configureUI() {
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
    }
    
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleForArlert)
        
        NSLayoutConstraint.activate([
            titleForArlert.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleForArlert.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleForArlert.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleForArlert.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
    
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
    }
    
    func configureBodyLabel() {
        containerView.addSubview(message)
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: titleForArlert.bottomAnchor, constant: padding),
            message.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            message.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            message.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -padding)
        
        ])
    }
    
    

}
