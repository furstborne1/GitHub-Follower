//
//  User.swift
//  GitHub Follower
//
//  Created by MARC on 4/18/20.
//  Copyright © 2020 MARC. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var bio: String?
    var createdAt: String
    var location: String?
    var name: String?
    var publicRepos: Int
    var publicGists: Int
    var htmUrl: String
    var following: Int
    var followers: Int
}
