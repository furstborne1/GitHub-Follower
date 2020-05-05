//
//  UIView+ext.swift
//  GitHub Follower
//
//  Created by MARC on 5/4/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

extension UIView  {
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    func pinEdges(to superView: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
