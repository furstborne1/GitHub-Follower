//
//  GFFollowerVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/29/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFFollowerVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
   private func setupView() {
        itemOneView.set(infoItem: .follower, withCounter: user.followers)
        itemTwoView.set(infoItem: .following, withCounter: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtondidPress() {
        delegate.didTapFollowerButton()
    }
}
