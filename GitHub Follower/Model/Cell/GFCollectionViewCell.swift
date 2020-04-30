//
//  GFCollectionViewCell.swift
//  GitHub Follower
//
//  Created by MARC on 4/20/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "collectionID"
    let avatarImageView = GFUIImageView()
    let avatarLogin = GFTitle(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        avatarLogin.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    
   private func configureContraints() {
        addSubview(avatarImageView)
        addSubview(avatarLogin)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            avatarLogin.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            avatarLogin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarLogin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarLogin.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
    
}
