//
//  FavoriteListVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/16/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class FavoriteListVC: UIViewController {
    
    let tableView = UITableView()
    var favorite  = [Follower]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setTableView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFavorite()
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExtraCell()
        tableView.rowHeight = 80
        tableView.frame = view.bounds
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func setFavorite() {
        PersistentManger.retrievedFavorites { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let favorite):
                self.favorite = favorite
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                self.presentGFAlertVC(title: "OH OH", body: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let selectedView = UIView()
        selectedView.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0.1987104024)
        cell.selectedBackgroundView = selectedView
        let user = favorite[indexPath.row]
        cell.set(favorite: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = favorite[indexPath.row]
        let destVC = UserInfoVC()
        destVC.follower = user
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let user = favorite[indexPath.row]
        favorite.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        PersistentManger.updateWith(follower: user, update: .remove) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlertVC(title: "OOH OOH", body: error.rawValue, buttonTitle: "ok")
        }
    }
    
    
}
