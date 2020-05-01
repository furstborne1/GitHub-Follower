//
//  GFItemInfoVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/29/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView       = UIStackView()
    let itemOneView     = GFItemInfoView()
    let itemTwoView     = GFItemInfoView()
    let actionButton    = GFButton()
    
    var user: User!
    var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setLayout()
        setupStackView()

    }
    
    private func configureViewController() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func setupStackView() {
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemOneView)
        stackView.addArrangedSubview(itemTwoView)
    }
    
    
    private func setLayout() {
        let padding: CGFloat = 20
        view.addSubview(stackView)
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(actionButtondidPress), for: .touchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    @objc func actionButtondidPress() {}


}
