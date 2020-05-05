//
//  PersistentManager.swift
//  GitHub Follower
//
//  Created by MARC on 5/3/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

enum updateType {
    case add, remove
}

enum PersistentManger {
    
    static private let defaults = UserDefaults.standard
    
    enum defaultKey {
        static let key = "favorite"
    }
    
    
    static func updateWith(follower: Follower, update: updateType, completion: @escaping(GFError?) -> Void) {
        retrievedFavorites { (results) in
            switch results {
                
            case .success(let favorites):
                var retrieveData = favorites
        
                switch update {
                    
                case .add:
                    guard !retrieveData.contains(follower) else {
                        completion(.alreadyFavorite)
                        return
                    }
                    retrieveData.append(follower)
                case .remove:
                    retrieveData.removeAll { $0.login == follower.login }
                }
                
                completion(save(follower: retrieveData))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrievedFavorites(completion: @escaping(Result<[Follower],GFError>) -> Void) {
        
        guard let favorites = defaults.object(forKey: defaultKey.key) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorite = try decoder.decode([Follower].self, from: favorites)
            completion(.success(favorite))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(follower: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let favorite = try encoder.encode(follower)
            defaults.set(favorite, forKey: defaultKey.key)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
