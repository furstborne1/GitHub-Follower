//
//  GFEmptyStateView.swift
//  GitHub Follower
//
//  Created by MARC on 4/21/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let emptyStateLabel = GFTitle(textAlignment: .center, fontSize: 28)
    let emptyStateLogo = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(for message: String) {
        super.init(frame: .zero)
        emptyStateLabel.text = message
        configure()
    }
    
    
    func configure() {
        addSubview(emptyStateLabel)
        addSubview(emptyStateLogo)
        
        emptyStateLabel.numberOfLines = 3
        emptyStateLabel.textColor = .secondaryLabel
        
        emptyStateLogo.image = UIImage(named: "empty-state-logo")
        emptyStateLogo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            emptyStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            emptyStateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            emptyStateLabel.heightAnchor.constraint(equalToConstant: 200),
            
            emptyStateLogo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyStateLogo.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyStateLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            emptyStateLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        
        
        ])
        
        
    }
    
    
}
