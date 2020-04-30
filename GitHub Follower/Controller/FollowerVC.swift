//
//  FollowerVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/17/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class FollowerVC: UIViewController {
    
    enum section { case main }
    
    var username: String!
    var collectionView: UICollectionView!
    var followers = [Follower]()
    var dataSource: UICollectionViewDiffableDataSource<section,Follower>!
    var page = 1
    var hasFinishedLoading = true
    var isSearching = false
    
    var filteredFollowersArray = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureColllectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Follower"
        searchController.searchBar.delegate =  self
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        
        showLoadingVC()
        
        NetworkManager.shared.getFollowers(userName: username, for: page) { [weak self] (result) in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let follower):
                if follower.count < 100 {
                    self.hasFinishedLoading = false
                }
                self.followers.append(contentsOf: follower)
                if self.followers.isEmpty {
                    let message = "This user has no follower. Go follow them 😫"
                    DispatchQueue.main.async {
                        self.showEmptyStateViewe(message: message, for: self.view)
                    }
                }
                self.updataData(for: self.followers)
            case .failure(let error):
                self.presentGFAlertVC(title: "OH oh! 🥺", body: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    func configureColllectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCustomCollectionViewFlowLayout(for: view))
        collectionView.delegate = self
        collectionView.register(GFCollectionViewCell.self, forCellWithReuseIdentifier: GFCollectionViewCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, followers) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFCollectionViewCell.reuseID, for: indexPath) as! GFCollectionViewCell
            cell.set(follower: followers)
            return cell
        })
    }
    
    func updataData(for followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

extension FollowerVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            guard hasFinishedLoading else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowersArray : followers
        let follower = activeArray[indexPath.item]
        let destinationVC = UserInfoVC()
        destinationVC.follower = follower
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}

extension FollowerVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowersArray = followers.filter {$0.login.lowercased().contains(filter.lowercased()) }
        updataData(for: filteredFollowersArray)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updataData(for: followers)
    }
}
