//
//  UserInfoVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/22/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapUserProfileButton()
    func didTapFollowerButton()
}

class UserInfoVC: UIViewController {
    
    var containerView            = UIView()
    var containerOne             = UIView()
    var containerTwo             = UIView()
    var dateLabel                = GFBodyLabel(textAlignment: .center)
    var containerArray: [UIView] = []
    
    
    var user : User!
    var follower: Follower!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        doneButtonForNavController()
        setContainerView()
        getUser()
    }
    
    func doneButtonForNavController() {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = done
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func getUser() {
        NetworkManager.shared.getUser(userName: follower.login) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.user = user
                print(user)
            case .failure(let error):
                print("\(error)")
            }
            DispatchQueue.main.async { self.setupUIelement(user: self.user) }
        }
    }
    
    func setupUIelement(user: User) {
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerInfoVC = GFFollowerVC(user: user)
        followerInfoVC.delegate = self
        
        self.add(childVC: repoItemVC, to: self.containerOne)
        self.add(childVC: followerInfoVC, to: self.containerTwo)
        self.add(childVC: GFHeaderVC(user: self.user), to: self.containerView)
        self.dateLabel.text = "GitHub since \( self.user.createdAt.displayDate())"
    }
    
    func setContainerView() {
        let padding: CGFloat          = 20
        let heightContrainst: CGFloat = 160
        
        containerArray = [containerView, containerOne, containerTwo, dateLabel]
        for containers in containerArray {
            view.addSubview(containers)
            containers.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                containers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                containers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ])
        }

        containerView.backgroundColor = .tertiarySystemBackground
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            
            containerOne.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: padding),
            containerOne.heightAnchor.constraint(equalToConstant: heightContrainst),
            
            containerTwo.topAnchor.constraint(equalTo: containerOne.bottomAnchor, constant: padding),
            containerTwo.heightAnchor.constraint(equalToConstant: heightContrainst),
            
            dateLabel.topAnchor.constraint(equalTo: containerTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
extension UserInfoVC: UserInfoVCDelegate {
    func didTapUserProfileButton() {
        print("fuck you mark")
    }
    
    func didTapFollowerButton() {
        //
    }
    
    
}
