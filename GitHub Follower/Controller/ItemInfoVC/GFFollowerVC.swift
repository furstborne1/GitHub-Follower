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
        itemOneView.set(infoItem: .gists, withCounter: user.publicGists)
        itemTwoView.set(infoItem: .following, withCounter: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
