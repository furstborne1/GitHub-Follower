//
//  GFItemInfoView.swift
//  GitHub Follower
//
//  Created by MARC on 4/29/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

enum infoItemType {
    case repos, follower, following, gists
}

class GFItemInfoView: UIView {
    
    let SFSymbolImageView = UIImageView()
    let TitleLabel        = GFTitle(textAlignment: .left, fontSize: 14)
    let counterLabel      = GFTitle(textAlignment: .center, fontSize: 14)
    
    var UIVIewArray: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        UIVIewArray = [SFSymbolImageView, TitleLabel, counterLabel]
        for views in UIVIewArray {
            addSubview(views)
        }
        SFSymbolImageView.translatesAutoresizingMaskIntoConstraints = false
        SFSymbolImageView.tintColor = .label
        SFSymbolImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            SFSymbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            SFSymbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            SFSymbolImageView.widthAnchor.constraint(equalToConstant: 20),
            SFSymbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            TitleLabel.centerYAnchor.constraint(equalTo: SFSymbolImageView.centerYAnchor),
            TitleLabel.leadingAnchor.constraint(equalTo: SFSymbolImageView.trailingAnchor, constant: 12),
            TitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            TitleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            counterLabel.topAnchor.constraint(equalTo: SFSymbolImageView.bottomAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            counterLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    
    func set(infoItem: infoItemType, withCounter counter: Int) {
        switch infoItem {
            
        case .repos:
            SFSymbolImageView.image = UIImage(systemName: SFSymbol.repos)
            TitleLabel.text         = "Public Repos"
        case .follower:
            SFSymbolImageView.image = UIImage(systemName: SFSymbol.gists)
            TitleLabel.text         = "Public Gists"
        case .following:
            SFSymbolImageView.image = UIImage(systemName: SFSymbol.following)
            TitleLabel.text         = "Following"
        case .gists:
            SFSymbolImageView.image = UIImage(systemName: SFSymbol.follower)
            TitleLabel.text         = "Followers"
        }
        counterLabel.text = String(counter)
    }
    
}
