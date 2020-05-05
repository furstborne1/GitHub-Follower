//
//  ViewController+ext.swift
//  GitHub Follower
//
//  Created by MARC on 4/17/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!


extension UIViewController {
    func presentGFAlertVC(title: String, body: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, messageLabel: body, buttonLabel: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariViewComntroller(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showLoadingVC() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.5) { containerView.alpha = 0.8 }
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        indicatorView.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async { containerView.removeFromSuperview() }
    }
    
    func showEmptyStateViewe(message: String, for View: UIView) {
        let emptyStateView = GFEmptyStateView(for: message)
        emptyStateView.frame = View.bounds
        View.addSubview(emptyStateView)
        
    }
    
}
