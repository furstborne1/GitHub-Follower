//
//  GFRepoItemVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/29/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
   private func setupView() {
        itemOneView.set(infoItem: .repos, withCounter: user.publicRepos)
        itemTwoView.set(infoItem: .follower, withCounter: user.followers)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
