//
//  UserInfoVC.swift
//  GitHub Follower
//
//  Created by MARC on 4/22/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit
import SafariServices

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
    let scrollView               = UIScrollView()
    let contentView              = UIView()
    
    
    var user : User!
    var follower: Follower!
    var delegate: FollowVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        doneButtonForNavController()
        setContainerView()
        getUser()
        configureScrollView()
    }
    
    func doneButtonForNavController() {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = done
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinEdges(to: view)
        contentView.pinEdges(to: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.size.height)
        ])
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
            contentView.addSubview(containers)
            containers.translatesAutoresizingMaskIntoConstraints = false
        
            NSLayoutConstraint.activate([
                containers.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                containers.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            ])
        }

        containerView.backgroundColor = .tertiarySystemBackground
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
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
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertVC(title: "OH OH bad URL", body: "this user url is not valid. Please try again later", buttonTitle: "ok")
            return
        }
        presentSafariViewComntroller(with: url)
        
    }
    
    func didTapFollowerButton() {
        guard user.followers != 0 else {
            presentGFAlertVC(title: "OHOH", body: "This user has no followers 😡", buttonTitle: "What a shame!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
