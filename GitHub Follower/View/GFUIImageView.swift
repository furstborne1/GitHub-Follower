//
//  GFUIImageView.swift
//  GitHub Follower
//
//  Created by MARC on 4/20/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class GFUIImageView: UIImageView {
    
    let placeholder = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = placeholder
    }
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { [weak self] (data, urlResponse, error) in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
            
        }
        session.resume()
    }
    
}
