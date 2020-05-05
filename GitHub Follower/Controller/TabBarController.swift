//
//  TabBarController.swift
//  GitHub Follower
//
//  Created by MARC on 5/4/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchVC(), createFavoriteVC()]
    }
    
    func createSearchVC() -> UINavigationController {
         let searchVC = SearchVC()
         searchVC.title = "Search"
         searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
         return UINavigationController(rootViewController: searchVC)
         
     }
     
     func createFavoriteVC() -> UINavigationController {
         let favoriteVC = FavoriteListVC()
         favoriteVC.title = "Favorites"
         favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
         return UINavigationController(rootViewController: favoriteVC)
     }
     
}
