//
//  FavoriteCell.swift
//  GitHub Follower
//
//  Created by MARC on 5/3/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "favoriteCell"
    let avatarImageView = GFUIImageView()
    let avatarLogin = GFTitle(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Follower) {
        avatarLogin.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    
    private func configureCell() {
        addSubview(avatarImageView)
        addSubview(avatarLogin)
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            avatarLogin.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarLogin.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            avatarLogin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            avatarLogin.heightAnchor.constraint(equalToConstant: 80)
        
        ])
    }
    
}
