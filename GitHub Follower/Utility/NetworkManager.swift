//
//  NetworkManager.swift
//  GitHub Follower
//
//  Created by MARC on 4/19/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://api.github.com/users/"
    
    typealias username = String
    typealias page = Int
    
    //MARK:- this is enum for error handling && for popupview meassage
    
    private init(){}
    
    func getFollowers(userName: username, for page: page, completion: @escaping(Result<[Follower], GFError>) -> ()) {
        let endpoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidRequestErrorMessage))
            return
        }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure( .checkInternetConnectionError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponseFromServer))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.invalidData))
            }
        }
        session.resume()
    }
    
    
    func getUser(userName: username, completion: @escaping(Result<User, GFError>) -> ()) {
        let endpoint = baseURL + "\(userName)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidRequestErrorMessage))
            return
        }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure( .checkInternetConnectionError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponseFromServer))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.invalidData))
            }
        }
        session.resume()
    }
    
    
}
