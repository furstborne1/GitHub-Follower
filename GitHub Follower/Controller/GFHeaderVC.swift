//
//  GFHeaderVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/22/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFHeaderVC: UIViewController {
    
    let avatarImage   = GFUIImageView(frame: .zero)
    let userNameLabel = GFTitle(textAlignment: .left, fontSize: 34)
    let nameLabel     = GFSecondaryLabel(fontSize: 18)
    let locationImage = UIImageView()
    let locationLabel = GFSecondaryLabel(fontSize: 18)
    let bioLabel      = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayoutView()
        configureUIelement()

    }
    
    func configureUIelement() {
        avatarImage.downloadImage(from: user.avatarUrl)
        userNameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImage.image = UIImage(systemName: "mappin.and.ellipse")
        locationImage.tintColor = .secondaryLabel
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "This user has no bio"
        bioLabel.numberOfLines = 4
    }
    
    func addSubviews() {
        view.addSubview(avatarImage)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImage)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func setLayoutView() {
        
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        let textToImage: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 90),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: textToImage),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: textToImage),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImage.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: textToImage),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.bottomAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: 2),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: textToImage),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 80)
            
            
            
        ])
    }

}
